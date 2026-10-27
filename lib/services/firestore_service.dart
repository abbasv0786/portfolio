import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../constants/profile.dart';
import '../data/portfolio_data.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/about_card.dart';
import '../models/tech_category.dart';
import '../models/approach_phase.dart';
import '../models/profile_info.dart';
import '../models/contact_message.dart';
import 'image_service.dart';

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find<FirestoreService>();

  late final FirebaseFirestore _firestore;

  // Reactive state data
  final RxList<Project> projects = <Project>[].obs;
  final RxList<Experience> experiences = <Experience>[].obs;
  final RxList<TechCategory> techCategories = <TechCategory>[].obs;
  final RxList<AboutCard> aboutCards = <AboutCard>[].obs;
  final RxList<ApproachPhase> approachPhases = <ApproachPhase>[].obs;
  final Rx<ProfileInfo> profileInfo = Rx<ProfileInfo>(_defaultProfileInfo);
  final RxList<ContactMessage> contactMessages = <ContactMessage>[].obs;

  // Loading states
  final RxBool isLoading = true.obs;
  final RxBool isSeeding = false.obs;
  final RxBool isMigratingImages = false.obs;
  final RxString error = ''.obs;

  // Active Firestore listeners, cancelled before re-subscribing
  final List<StreamSubscription> _contentSubs = [];
  StreamSubscription? _messagesSub;

  // Fallback defaults
  static const ProfileInfo _defaultProfileInfo = ProfileInfo(
    name: PortfolioData.name,
    title: PortfolioData.title,
    subtitle: PortfolioData.subtitle,
    tagline: PortfolioData.tagline,
    description: PortfolioData.description,
    location: PortfolioData.location,
    availability: PortfolioData.availability,
    email: PortfolioData.email,
    phone: PortfolioData.phone,
    whatsapp: PortfolioData.whatsapp,
    discord: PortfolioData.discord,
    telegram: PortfolioData.telegram,
    linkedin: PortfolioData.linkedin,
    twitter: PortfolioData.twitter,
    instagram: PortfolioData.instagram,
    github: 'https://github.com/abbasv0786',
    portfolioUrl: PortfolioData.portfolioUrl,
    cvUrl: '',
    footerDescription: PortfolioData.footerDescription,
    footerCopyright: PortfolioData.footerCopyright,
    yearsOfExperience: '8+',
    completedProjects: '20+',
    typingWords: [
      'Forward Deployed Engineer',
      'Implementation & Integration Lead',
      'Python / JavaScript / SQL Developer',
      'AI-Native Platform Specialist',
      'Cross-Functional Technical Leader',
    ],
  );

  @override
  void onInit() {
    super.onInit();
    _initFirestore();
  }

  void _initFirestore() {
    try {
      _firestore = FirebaseFirestore.instance;
      // Configure cache settings for high performance and offline capability
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
    } catch (e) {
      debugPrint('Firestore settings initialization note: $e');
      _firestore = FirebaseFirestore.instance;
    }

    // Set initial fallback data immediately so UI renders instantly without any wait
    _loadFallbackData();

    // Fetch and sync data in the background
    initDataSync();
  }

  void _loadFallbackData() {
    projects.assignAll(PortfolioData.projects);
    experiences.assignAll(PortfolioData.experiences);
    aboutCards.assignAll(PortfolioData.aboutCards);
    techCategories.assignAll(_defaultTechCategories);
    approachPhases.assignAll(_defaultApproachPhases);
    profileInfo.value = _defaultProfileInfo;
  }

  /// Initialize real-time listeners and initial data sync
  Future<void> initDataSync() async {
    isLoading.value = true;
    for (final sub in _contentSubs) {
      await sub.cancel();
    }
    _contentSubs.clear();
    try {
      await Future.wait([
        _syncProjects(),
        _syncExperiences(),
        _syncTechCategories(),
        _syncAboutCards(),
        _syncApproachPhases(),
        _syncProfileInfo(),
      ]);
    } catch (e) {
      debugPrint('Error syncing Firestore data: $e');
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // ================= PROJECTS =================
  Future<void> _syncProjects() async {
    try {
      _contentSubs.add(_firestore
          .collection('projects')
          .orderBy('order', descending: false)
          .snapshots(includeMetadataChanges: false)
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final list = snapshot.docs
              .map((doc) => Project.fromMap(doc.data(), doc.id))
              .toList();
          projects.assignAll(list);
        } else if (projects.isEmpty) {
          projects.assignAll(PortfolioData.projects);
        }
      }, onError: (e) {
        debugPrint('Projects stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to projects: $e');
    }
  }

  Future<void> createProject(Project project) async {
    final docRef = await _firestore.collection('projects').add(project.toMap());
    final newProject = project.copyWith(id: docRef.id);
    projects.add(newProject);
    projects.sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> updateProject(Project project) async {
    if (project.id == null || project.id!.isEmpty) {
      // Create new document in Firestore if id was null
      final docRef =
          await _firestore.collection('projects').add(project.toMap());
      final newProject = project.copyWith(id: docRef.id);
      final index = projects.indexWhere((p) => p.title == project.title);
      if (index != -1) {
        projects[index] = newProject;
      } else {
        projects.add(newProject);
      }
      projects.sort((a, b) => a.order.compareTo(b.order));
      return;
    }

    await _firestore
        .collection('projects')
        .doc(project.id)
        .set(project.toMap(), SetOptions(merge: true));
    final index = projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      projects[index] = project;
      projects.sort((a, b) => a.order.compareTo(b.order));
    }
  }

  Future<void> deleteProject(String? id, {String? title}) async {
    if (id != null && id.isNotEmpty) {
      await _firestore.collection('projects').doc(id).delete();
      projects.removeWhere((p) => p.id == id);
    } else if (title != null) {
      projects.removeWhere((p) => p.title == title);
    }
  }

  // ================= EXPERIENCES =================
  Future<void> _syncExperiences() async {
    try {
      _contentSubs.add(_firestore
          .collection('experiences')
          .orderBy('order', descending: false)
          .snapshots(includeMetadataChanges: false)
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final list = snapshot.docs
              .map((doc) => Experience.fromMap(doc.data(), doc.id))
              .toList();
          experiences.assignAll(list);
        } else if (experiences.isEmpty) {
          experiences.assignAll(PortfolioData.experiences);
        }
      }, onError: (e) {
        debugPrint('Experiences stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to experiences: $e');
    }
  }

  Future<void> createExperience(Experience experience) async {
    final docRef =
        await _firestore.collection('experiences').add(experience.toMap());
    final newExp = experience.copyWith(id: docRef.id);
    experiences.add(newExp);
    experiences.sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> updateExperience(Experience experience) async {
    if (experience.id == null || experience.id!.isEmpty) {
      final docRef =
          await _firestore.collection('experiences').add(experience.toMap());
      final newExp = experience.copyWith(id: docRef.id);
      final index =
          experiences.indexWhere((e) => e.company == experience.company);
      if (index != -1) {
        experiences[index] = newExp;
      } else {
        experiences.add(newExp);
      }
      experiences.sort((a, b) => a.order.compareTo(b.order));
      return;
    }

    await _firestore
        .collection('experiences')
        .doc(experience.id)
        .set(experience.toMap(), SetOptions(merge: true));
    final index = experiences.indexWhere((e) => e.id == experience.id);
    if (index != -1) {
      experiences[index] = experience;
      experiences.sort((a, b) => a.order.compareTo(b.order));
    }
  }

  Future<void> deleteExperience(String? id, {String? company}) async {
    if (id != null && id.isNotEmpty) {
      await _firestore.collection('experiences').doc(id).delete();
      experiences.removeWhere((e) => e.id == id);
    } else if (company != null) {
      experiences.removeWhere((e) => e.company == company);
    }
  }

  // ================= TECH CATEGORIES =================
  Future<void> _syncTechCategories() async {
    try {
      _contentSubs.add(_firestore
          .collection('tech_categories')
          .orderBy('order', descending: false)
          .snapshots(includeMetadataChanges: false)
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final list = snapshot.docs
              .map((doc) => TechCategory.fromMap(doc.data(), doc.id))
              .toList();
          techCategories.assignAll(list);
        } else if (techCategories.isEmpty) {
          techCategories.assignAll(_defaultTechCategories);
        }
      }, onError: (e) {
        debugPrint('TechCategories stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to tech categories: $e');
    }
  }

  Future<void> createTechCategory(TechCategory category) async {
    final docRef =
        await _firestore.collection('tech_categories').add(category.toMap());
    final newCat = category.copyWith(id: docRef.id);
    techCategories.add(newCat);
    techCategories.sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> updateTechCategory(TechCategory category) async {
    if (category.id == null || category.id!.isEmpty) {
      final docRef =
          await _firestore.collection('tech_categories').add(category.toMap());
      final newCat = category.copyWith(id: docRef.id);
      final index = techCategories.indexWhere((c) => c.title == category.title);
      if (index != -1) {
        techCategories[index] = newCat;
      } else {
        techCategories.add(newCat);
      }
      techCategories.sort((a, b) => a.order.compareTo(b.order));
      return;
    }

    await _firestore
        .collection('tech_categories')
        .doc(category.id)
        .set(category.toMap(), SetOptions(merge: true));
    final index = techCategories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      techCategories[index] = category;
      techCategories.sort((a, b) => a.order.compareTo(b.order));
    }
  }

  Future<void> deleteTechCategory(String? id, {String? title}) async {
    if (id != null && id.isNotEmpty) {
      await _firestore.collection('tech_categories').doc(id).delete();
      techCategories.removeWhere((c) => c.id == id);
    } else if (title != null) {
      techCategories.removeWhere((c) => c.title == title);
    }
  }

  // ================= ABOUT CARDS =================
  Future<void> _syncAboutCards() async {
    try {
      _contentSubs.add(_firestore
          .collection('about_cards')
          .orderBy('order', descending: false)
          .snapshots(includeMetadataChanges: false)
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final list = snapshot.docs
              .map((doc) => AboutCard.fromMap(doc.data(), doc.id))
              .toList();
          aboutCards.assignAll(list);
        } else if (aboutCards.isEmpty) {
          aboutCards.assignAll(PortfolioData.aboutCards);
        }
      }, onError: (e) {
        debugPrint('AboutCards stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to about cards: $e');
    }
  }

  Future<void> createAboutCard(AboutCard card) async {
    final docRef = await _firestore.collection('about_cards').add(card.toMap());
    final newCard = card.copyWith(id: docRef.id);
    aboutCards.add(newCard);
    aboutCards.sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> updateAboutCard(AboutCard card) async {
    if (card.id == null || card.id!.isEmpty) {
      final docRef =
          await _firestore.collection('about_cards').add(card.toMap());
      final newCard = card.copyWith(id: docRef.id);
      final index = aboutCards.indexWhere((c) => c.title == card.title);
      if (index != -1) {
        aboutCards[index] = newCard;
      } else {
        aboutCards.add(newCard);
      }
      aboutCards.sort((a, b) => a.order.compareTo(b.order));
      return;
    }

    await _firestore
        .collection('about_cards')
        .doc(card.id)
        .set(card.toMap(), SetOptions(merge: true));
    final index = aboutCards.indexWhere((c) => c.id == card.id);
    if (index != -1) {
      aboutCards[index] = card;
      aboutCards.sort((a, b) => a.order.compareTo(b.order));
    }
  }

  Future<void> deleteAboutCard(String? id, {String? title}) async {
    if (id != null && id.isNotEmpty) {
      await _firestore.collection('about_cards').doc(id).delete();
      aboutCards.removeWhere((c) => c.id == id);
    } else if (title != null) {
      aboutCards.removeWhere((c) => c.title == title);
    }
  }

  // ================= APPROACH PHASES =================
  Future<void> _syncApproachPhases() async {
    try {
      _contentSubs.add(_firestore
          .collection('approach_phases')
          .orderBy('order', descending: false)
          .snapshots(includeMetadataChanges: false)
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final list = snapshot.docs
              .map((doc) => ApproachPhase.fromMap(doc.data(), doc.id))
              .toList();
          approachPhases.assignAll(list);
        } else if (approachPhases.isEmpty) {
          approachPhases.assignAll(_defaultApproachPhases);
        }
      }, onError: (e) {
        debugPrint('ApproachPhases stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to approach phases: $e');
    }
  }

  Future<void> createApproachPhase(ApproachPhase phase) async {
    final docRef =
        await _firestore.collection('approach_phases').add(phase.toMap());
    final newPhase = phase.copyWith(id: docRef.id);
    approachPhases.add(newPhase);
    approachPhases.sort((a, b) => a.order.compareTo(b.order));
  }

  Future<void> updateApproachPhase(ApproachPhase phase) async {
    if (phase.id == null || phase.id!.isEmpty) {
      final docRef =
          await _firestore.collection('approach_phases').add(phase.toMap());
      final newPhase = phase.copyWith(id: docRef.id);
      final index = approachPhases.indexWhere((p) => p.title == phase.title);
      if (index != -1) {
        approachPhases[index] = newPhase;
      } else {
        approachPhases.add(newPhase);
      }
      approachPhases.sort((a, b) => a.order.compareTo(b.order));
      return;
    }

    await _firestore
        .collection('approach_phases')
        .doc(phase.id)
        .set(phase.toMap(), SetOptions(merge: true));
    final index = approachPhases.indexWhere((p) => p.id == phase.id);
    if (index != -1) {
      approachPhases[index] = phase;
      approachPhases.sort((a, b) => a.order.compareTo(b.order));
    }
  }

  Future<void> deleteApproachPhase(String? id, {String? title}) async {
    if (id != null && id.isNotEmpty) {
      await _firestore.collection('approach_phases').doc(id).delete();
      approachPhases.removeWhere((p) => p.id == id);
    } else if (title != null) {
      approachPhases.removeWhere((p) => p.title == title);
    }
  }

  // ================= PROFILE INFO =================
  Future<void> _syncProfileInfo() async {
    try {
      _contentSubs.add(_firestore
          .collection('profile')
          .doc('info')
          .snapshots(includeMetadataChanges: false)
          .listen((doc) {
        if (doc.exists && doc.data() != null) {
          profileInfo.value = ProfileInfo.fromMap(doc.data()!, doc.id);
        }
      }, onError: (e) {
        debugPrint('ProfileInfo stream error: $e');
      }));
    } catch (e) {
      debugPrint('Error subscribing to profile info: $e');
    }
  }

  Future<void> updateProfileInfo(ProfileInfo info) async {
    await _firestore
        .collection('profile')
        .doc('info')
        .set(info.toMap(), SetOptions(merge: true));
    profileInfo.value = info;
  }

  // ================= CONTACT MESSAGES =================
  Future<void> saveContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final msg = ContactMessage(
      name: name,
      email: email,
      message: message,
      createdAt: DateTime.now(),
      isRead: false,
    );
    await _firestore.collection('contact_messages').add(msg.toMap());
  }

  /// Admin-only: start listening to contact messages (no-op if already listening)
  void syncContactMessages() {
    if (_messagesSub != null) return;
    _messagesSub = _firestore
        .collection('contact_messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => ContactMessage.fromMap(doc.data(), doc.id))
          .toList();
      contactMessages.assignAll(list);
    }, onError: (e) {
      debugPrint('Contact messages stream error: $e');
    });
  }

  void stopContactMessages() {
    _messagesSub?.cancel();
    _messagesSub = null;
    contactMessages.clear();
  }

  Future<void> markMessageAsRead(String id, bool isRead) async {
    await _firestore
        .collection('contact_messages')
        .doc(id)
        .update({'isRead': isRead});
    final index = contactMessages.indexWhere((m) => m.id == id);
    if (index != -1) {
      contactMessages[index] = contactMessages[index].copyWith(isRead: isRead);
    }
  }

  Future<void> deleteContactMessage(String id) async {
    await _firestore.collection('contact_messages').doc(id).delete();
    contactMessages.removeWhere((m) => m.id == id);
  }

  // ================= IMAGES INTO FIRESTORE =================
  /// Copies bundled asset images (projects + profile photo) into their
  /// Firestore records, so they can be replaced from the admin panel.
  /// Returns how many images were moved.
  Future<int> migrateImagesToFirestore() async {
    isMigratingImages.value = true;
    var moved = 0;
    try {
      for (final p in projects.toList()) {
        if (!ImageService.isAsset(p.imageUrl)) continue;
        final dataUrl = await ImageService.assetToDataUrl(p.imageUrl);
        await updateProject(p.copyWith(imageUrl: dataUrl));
        moved++;
      }
      final photo = profileInfo.value.profileImageUrl;
      if (photo.isEmpty || ImageService.isAsset(photo)) {
        final dataUrl = await ImageService.assetToDataUrl(
            photo.isEmpty ? ProfileConstants.profileImagePath : photo);
        await updateProfileInfo(
            profileInfo.value.copyWith(profileImageUrl: dataUrl));
        moved++;
      }
      return moved;
    } finally {
      isMigratingImages.value = false;
    }
  }

  // ================= ONE-CLICK SEED TO FIRESTORE =================
  /// Migrates all local data from `PortfolioData` into Firestore!
  Future<void> seedDefaultData({bool overwrite = false}) async {
    isSeeding.value = true;
    try {
      final batch = _firestore.batch();

      // 1. Profile Info
      final profileDoc = _firestore.collection('profile').doc('info');
      final profileSnap = await profileDoc.get();
      if (!profileSnap.exists || overwrite) {
        batch.set(profileDoc, _defaultProfileInfo.toMap());
      }

      // 2. Projects
      final projectsCol = _firestore.collection('projects');
      final projectsSnap = await projectsCol.limit(1).get();
      if (projectsSnap.docs.isEmpty || overwrite) {
        // If overwriting, clear existing docs first
        if (overwrite) {
          final allProjects = await projectsCol.get();
          for (var doc in allProjects.docs) {
            batch.delete(doc.reference);
          }
        }
        for (int i = 0; i < PortfolioData.projects.length; i++) {
          final p = PortfolioData.projects[i];
          final doc = projectsCol.doc();
          batch.set(doc, p.copyWith(order: i).toMap());
        }
      }

      // 3. Experiences
      final expCol = _firestore.collection('experiences');
      final expSnap = await expCol.limit(1).get();
      if (expSnap.docs.isEmpty || overwrite) {
        if (overwrite) {
          final allExp = await expCol.get();
          for (var doc in allExp.docs) {
            batch.delete(doc.reference);
          }
        }
        for (int i = 0; i < PortfolioData.experiences.length; i++) {
          final e = PortfolioData.experiences[i];
          final doc = expCol.doc();
          batch.set(doc, e.copyWith(order: i).toMap());
        }
      }

      // 4. Tech Categories
      final catCol = _firestore.collection('tech_categories');
      final catSnap = await catCol.limit(1).get();
      if (catSnap.docs.isEmpty || overwrite) {
        if (overwrite) {
          final allCats = await catCol.get();
          for (var doc in allCats.docs) {
            batch.delete(doc.reference);
          }
        }
        for (int i = 0; i < _defaultTechCategories.length; i++) {
          final c = _defaultTechCategories[i];
          final doc = catCol.doc();
          batch.set(doc, c.copyWith(order: i).toMap());
        }
      }

      // 5. About Cards
      final aboutCol = _firestore.collection('about_cards');
      final aboutSnap = await aboutCol.limit(1).get();
      if (aboutSnap.docs.isEmpty || overwrite) {
        if (overwrite) {
          final allAbout = await aboutCol.get();
          for (var doc in allAbout.docs) {
            batch.delete(doc.reference);
          }
        }
        for (int i = 0; i < PortfolioData.aboutCards.length; i++) {
          final a = PortfolioData.aboutCards[i];
          final doc = aboutCol.doc();
          batch.set(doc, a.copyWith(order: i).toMap());
        }
      }

      // 6. Approach Phases
      final approachCol = _firestore.collection('approach_phases');
      final approachSnap = await approachCol.limit(1).get();
      if (approachSnap.docs.isEmpty || overwrite) {
        if (overwrite) {
          final allApp = await approachCol.get();
          for (var doc in allApp.docs) {
            batch.delete(doc.reference);
          }
        }
        for (int i = 0; i < _defaultApproachPhases.length; i++) {
          final ap = _defaultApproachPhases[i];
          final doc = approachCol.doc();
          batch.set(doc, ap.copyWith(order: i).toMap());
        }
      }

      await batch.commit();
      debugPrint('Successfully seeded Firestore data!');
      await initDataSync();
    } catch (e) {
      debugPrint('Error seeding default data: $e');
      rethrow;
    } finally {
      isSeeding.value = false;
    }
  }

  // Static default lists
  static final List<TechCategory> _defaultTechCategories = [
    const TechCategory(
      title: 'Languages & Core',
      skills: [
        'Python',
        'JavaScript / TypeScript',
        'SQL (PostgreSQL, SQL Server)',
        'Dart',
        'Swift',
        'HTML / CSS',
      ],
      color: 0xFF54C5F8,
      order: 0,
    ),
    const TechCategory(
      title: 'AI & Integration',
      skills: [
        'LangChain / LangGraph',
        'RAG Pipelines',
        'Agentic AI Workflows',
        'Azure AI Search',
        'Azure Document Intelligence',
        'Conversational AI / Chatbots',
        'Vector & Semantic Search',
        'Prompt Engineering',
      ],
      color: 0xFFFFD700,
      order: 1,
    ),
    const TechCategory(
      title: 'Backend & APIs',
      skills: [
        'FastAPI',
        'REST APIs',
        'GraphQL',
        'Dio / Retrofit',
        'WebSockets',
        'OAuth 2.0 / JWT',
        'Swagger / OpenAPI',
        'Interceptor-Driven Auth',
      ],
      color: 0xFF7B68EE,
      order: 2,
    ),
    const TechCategory(
      title: 'Implementation & Delivery',
      skills: [
        'Technical Discovery & Scoping',
        'Customer Timeline Management',
        'Integration Debugging',
        'Delivery Playbooks',
        'Escalation Management',
        'Launch Readiness',
        'Cross-Functional Coordination',
        'Data-Driven Roadmap Influence',
      ],
      color: 0xFF64FFDA,
      order: 3,
    ),
    const TechCategory(
      title: 'Frontend & Mobile',
      skills: [
        'Flutter (Web & Mobile)',
        'React / React Native',
        'Clean Architecture (MVVM)',
        'BLoC / Riverpod / Provider',
        'Platform Channels',
        'Reusable Component Libraries',
      ],
      color: 0xFF00BFFF,
      order: 4,
    ),
    const TechCategory(
      title: 'Cloud & DevOps',
      skills: [
        'Azure (AI Services, Functions)',
        'GCP (Cloud Run, Firestore)',
        'AWS',
        'Docker / Kubernetes',
        'GitHub Actions / CI/CD',
        'Fastlane',
        'Firebase',
      ],
      color: 0xFFFF6B6B,
      order: 5,
    ),
    const TechCategory(
      title: 'Testing & Quality',
      skills: [
        'pytest / Unit Testing',
        'Widget & Integration Tests',
        'Golden Tests (UI Regression)',
        'TDD',
        'RAGAS Evaluation',
        'LangSmith Observability',
        'Automated Test Pipelines',
      ],
      color: 0xFF4ECDC4,
      order: 6,
    ),
    const TechCategory(
      title: 'Databases & Storage',
      skills: [
        'PostgreSQL / MySQL',
        'SQL Server',
        'MongoDB / Firestore',
        'SQLite / Hive',
        'Pinecone (Vector DB)',
        'Azure Blob Storage',
        'Secure Encrypted Storage',
      ],
      color: 0xFFE6A4B4,
      order: 7,
    ),
  ];

  static final List<ApproachPhase> _defaultApproachPhases = [
    ApproachPhase(
      phaseNumber: 0,
      title: 'Discovery & Scoping',
      description:
          'Lead technical discovery calls with customers — translate ambiguous requirements into scoped stories, anticipate blockers, and build implementation roadmaps aligned with product strengths.',
      icon: '📋',
      duration: '1-2 weeks',
      details: [
        'Requirements gathering and analysis',
        'Project scope definition',
        'Technology stack selection',
        'Timeline and milestone planning',
        'Risk assessment and mitigation',
      ],
      color: 0xFF64FFDA,
      order: 0,
    ),
    ApproachPhase(
      phaseNumber: 1,
      title: 'Implementation & Integration',
      description:
          'Write and debug production integration code in Python, JavaScript, and SQL. Design robust solutions tailored to client-specific constraints. Manage timelines, escalate issues, and ensure launch readiness.',
      icon: '⚡',
      duration: '2-8 weeks',
      details: [
        'Agile development methodology',
        'Code review and quality assurance',
        'Regular progress updates',
        'Performance optimization',
        'Security implementation',
      ],
      color: 0xFF7B68EE,
      order: 1,
    ),
    ApproachPhase(
      phaseNumber: 2,
      title: 'Launch & Feedback Loop',
      description:
          'Drive successful deployments, communicate findings clearly to stakeholders, and influence product roadmap priorities through structured, data-driven feedback from real-world deployments.',
      icon: '🚀',
      duration: '1-2 weeks',
      details: [
        'Production environment setup',
        'Deployment automation',
        'Monitoring and analytics',
        'User training and documentation',
        'Post-launch support and maintenance',
      ],
      color: 0xFFFF6B6B,
      order: 2,
    ),
  ];
}
