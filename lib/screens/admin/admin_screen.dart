import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../services/image_service.dart';
import '../../widgets/app_image.dart';
import '../../models/project.dart';
import '../../models/experience.dart';
import '../../models/tech_category.dart';
import '../../models/about_card.dart';
import '../../models/approach_phase.dart';
import 'widgets/about_card_dialog.dart';
import 'widgets/approach_phase_dialog.dart';
import 'widgets/experience_dialog.dart';
import 'widgets/project_dialog.dart';
import 'widgets/tech_category_dialog.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Login form controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Profile form controllers
  final _profileFormKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _titleCtrl;
  late TextEditingController _subtitleCtrl;
  late TextEditingController _taglineCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _availabilityCtrl;
  late TextEditingController _emailContactCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _whatsappCtrl;
  late TextEditingController _discordCtrl;
  late TextEditingController _telegramCtrl;
  late TextEditingController _linkedinCtrl;
  late TextEditingController _twitterCtrl;
  late TextEditingController _instagramCtrl;
  late TextEditingController _githubCtrl;
  late TextEditingController _yearsExpCtrl;
  late TextEditingController _completedProjectsCtrl;
  late TextEditingController _cvUrlCtrl;
  late TextEditingController _profileImageCtrl;
  bool _isUploadingPhoto = false;
  late TextEditingController _portfolioUrlCtrl;
  late TextEditingController _footerDescCtrl;
  late TextEditingController _footerCopyrightCtrl;
  late TextEditingController _typingWordsCtrl;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);

    _initProfileControllers();

    // Listen to profile updates from Firestore
    if (Get.isRegistered<FirestoreService>()) {
      ever(FirestoreService.to.profileInfo, (info) {
        if (mounted) {
          // If controllers are empty or unchanged, update them with live data
          if (_nameCtrl.text.isEmpty || _nameCtrl.text == 'AhemadAbbas Vagh') {
            _populateProfileControllers(info);
          }
        }
      });
    }
  }

  void _initProfileControllers() {
    final info = Get.isRegistered<FirestoreService>()
        ? FirestoreService.to.profileInfo.value
        : null;

    _nameCtrl = TextEditingController(text: info?.name ?? '');
    _titleCtrl = TextEditingController(text: info?.title ?? '');
    _subtitleCtrl = TextEditingController(text: info?.subtitle ?? '');
    _taglineCtrl = TextEditingController(text: info?.tagline ?? '');
    _descCtrl = TextEditingController(text: info?.description ?? '');
    _locationCtrl = TextEditingController(text: info?.location ?? '');
    _availabilityCtrl = TextEditingController(text: info?.availability ?? '');
    _emailContactCtrl = TextEditingController(text: info?.email ?? '');
    _phoneCtrl = TextEditingController(text: info?.phone ?? '');
    _whatsappCtrl = TextEditingController(text: info?.whatsapp ?? '');
    _discordCtrl = TextEditingController(text: info?.discord ?? '');
    _telegramCtrl = TextEditingController(text: info?.telegram ?? '');
    _linkedinCtrl = TextEditingController(text: info?.linkedin ?? '');
    _twitterCtrl = TextEditingController(text: info?.twitter ?? '');
    _instagramCtrl = TextEditingController(text: info?.instagram ?? '');
    _githubCtrl = TextEditingController(text: info?.github ?? '');
    _yearsExpCtrl =
        TextEditingController(text: info?.yearsOfExperience ?? '8+');
    _completedProjectsCtrl =
        TextEditingController(text: info?.completedProjects ?? '20+');
    _cvUrlCtrl = TextEditingController(text: info?.cvUrl ?? '');
    _profileImageCtrl =
        TextEditingController(text: info?.profileImageUrl ?? '');
    _portfolioUrlCtrl = TextEditingController(text: info?.portfolioUrl ?? '');
    _footerDescCtrl =
        TextEditingController(text: info?.footerDescription ?? '');
    _footerCopyrightCtrl =
        TextEditingController(text: info?.footerCopyright ?? '');
    _typingWordsCtrl =
        TextEditingController(text: info?.typingWords.join(', ') ?? '');
  }

  void _populateProfileControllers(dynamic info) {
    if (info == null) return;
    _nameCtrl.text = info.name ?? '';
    _titleCtrl.text = info.title ?? '';
    _subtitleCtrl.text = info.subtitle ?? '';
    _taglineCtrl.text = info.tagline ?? '';
    _descCtrl.text = info.description ?? '';
    _locationCtrl.text = info.location ?? '';
    _availabilityCtrl.text = info.availability ?? '';
    _emailContactCtrl.text = info.email ?? '';
    _phoneCtrl.text = info.phone ?? '';
    _whatsappCtrl.text = info.whatsapp ?? '';
    _discordCtrl.text = info.discord ?? '';
    _telegramCtrl.text = info.telegram ?? '';
    _linkedinCtrl.text = info.linkedin ?? '';
    _twitterCtrl.text = info.twitter ?? '';
    _instagramCtrl.text = info.instagram ?? '';
    _githubCtrl.text = info.github ?? '';
    _yearsExpCtrl.text = info.yearsOfExperience ?? '8+';
    _completedProjectsCtrl.text = info.completedProjects ?? '20+';
    _cvUrlCtrl.text = info.cvUrl ?? '';
    _profileImageCtrl.text = info.profileImageUrl ?? '';
    _portfolioUrlCtrl.text = info.portfolioUrl ?? '';
    _footerDescCtrl.text = info.footerDescription ?? '';
    _footerCopyrightCtrl.text = info.footerCopyright ?? '';
    if (info.typingWords != null && info.typingWords is List) {
      _typingWordsCtrl.text = (info.typingWords as List).join(', ');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameCtrl.dispose();
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _taglineCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _availabilityCtrl.dispose();
    _emailContactCtrl.dispose();
    _phoneCtrl.dispose();
    _whatsappCtrl.dispose();
    _discordCtrl.dispose();
    _telegramCtrl.dispose();
    _linkedinCtrl.dispose();
    _twitterCtrl.dispose();
    _instagramCtrl.dispose();
    _githubCtrl.dispose();
    _yearsExpCtrl.dispose();
    _completedProjectsCtrl.dispose();
    _cvUrlCtrl.dispose();
    _profileImageCtrl.dispose();
    _portfolioUrlCtrl.dispose();
    _footerDescCtrl.dispose();
    _footerCopyrightCtrl.dispose();
    _typingWordsCtrl.dispose();
    super.dispose();
  }

  void _showMessage(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isError ? Colors.red.shade800 : AppColors.accent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Get.isRegistered<AuthService>() ? AuthService.to : null;

    return Obx(() {
      final isLoggedIn = authService?.isAuthenticated ?? false;

      if (!isLoggedIn) {
        return _buildLoginView();
      }

      return _buildDashboardView();
    });
  }

  // ==========================================
  // LOGIN VIEW
  // ==========================================
  Widget _buildLoginView() {
    final authService = AuthService.to;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.glassBorder.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / Icon
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.3)),
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
                        size: 42,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Admin Portal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Manage your portfolio data & Firestore database',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),

                  // Error message if any
                  Obx(() {
                    if (authService.authError.value.isNotEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.red.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          authService.authError.value,
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 13),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),

                  _buildInputField(
                    controller: _emailController,
                    label: 'Admin Email',
                    hint: 'name@example.com',
                    prefixIcon: Icons.email_outlined,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: '••••••••',
                    isPassword: _obscurePassword,
                    prefixIcon: Icons.lock_outline,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) => _handleLogin(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Prominent Primary Login Button
                  Obx(() {
                    final isLoading = authService.isLoading.value;
                    return Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF8B5CF6).withValues(alpha: 0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : _handleLogin,
                        icon: isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.login_rounded,
                                color: Colors.white, size: 20),
                        label: Text(
                          isLoading ? 'Signing In...' : 'Log In as Admin',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(RouteNames.home),
                    icon: const Icon(Icons.arrow_back,
                        size: 16, color: AppColors.textSecondary),
                    label: const Text(
                      'Return to Portfolio',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();
    if (email.isEmpty || pass.isEmpty) {
      _showMessage('Please enter email and password', isError: true);
      return;
    }
    final success = await AuthService.to.signInWithEmailPassword(email, pass);
    if (success) {
      _showMessage('Welcome back, Admin!');
    }
  }

  // ==========================================
  // DASHBOARD VIEW
  // ==========================================
  Widget _buildDashboardView() {
    final firestore = FirestoreService.to;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundCard,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.dashboard_customize_rounded,
                color: AppColors.accent, size: 24),
            const SizedBox(width: 10),
            const Text(
              'Portfolio Admin',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.4)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.cloud_done_rounded,
                        color: Colors.greenAccent, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Firestore Connected',
                      style: TextStyle(color: Colors.greenAccent, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          // Quick seed button
          TextButton.icon(
            onPressed: () => _confirmSeed(context),
            icon: const Icon(Icons.sync_rounded,
                color: AppColors.accent, size: 18),
            label: Text(
              isMobile ? 'Sync' : 'Seed Firestore',
              style: const TextStyle(
                  color: AppColors.accent, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            tooltip: 'View Live Portfolio',
            icon: const Icon(Icons.visibility_outlined,
                color: AppColors.textSecondary),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(RouteNames.home),
          ),
          IconButton(
            tooltip: 'Sign Out',
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () => AuthService.to.signOut(),
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textSecondary,
          tabAlignment: TabAlignment.start,
          tabs: [
            const Tab(icon: Icon(Icons.bar_chart_rounded), text: 'Overview'),
            Tab(
              icon: const Icon(Icons.folder_special_rounded),
              text: 'Projects (${firestore.projects.length})',
            ),
            Tab(
              icon: const Icon(Icons.work_history_rounded),
              text: 'Experience (${firestore.experiences.length})',
            ),
            Tab(
              icon: const Icon(Icons.code_rounded),
              text: 'Skills (${firestore.techCategories.length})',
            ),
            const Tab(
              icon: Icon(Icons.info_outline_rounded),
              text: 'About & Approach',
            ),
            const Tab(
              icon: Icon(Icons.person_outline_rounded),
              text: 'Profile & Contact',
            ),
            Tab(
              icon: const Icon(Icons.mark_email_unread_rounded),
              text: 'Messages (${firestore.contactMessages.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildProjectsTab(),
          _buildExperienceTab(),
          _buildSkillsTab(),
          _buildAboutApproachTab(),
          _buildProfileTab(),
          _buildMessagesTab(),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: OVERVIEW & SEED
  // ==========================================
  Widget _buildOverviewTab() {
    final firestore = FirestoreService.to;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Overview & Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage all dynamic content streamed from Firebase Firestore with zero downtime fallbacks.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // Stat Cards Grid
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                title: 'Total Projects',
                count: firestore.projects.length.toString(),
                icon: Icons.rocket_launch_rounded,
                color: const Color(0xFF64FFDA),
              ),
              _buildStatCard(
                title: 'Experiences',
                count: firestore.experiences.length.toString(),
                icon: Icons.business_center_rounded,
                color: const Color(0xFF7B68EE),
              ),
              _buildStatCard(
                title: 'Skill Categories',
                count: firestore.techCategories.length.toString(),
                icon: Icons.psychology_rounded,
                color: const Color(0xFFFFD700),
              ),
              _buildStatCard(
                title: 'Contact Messages',
                count: firestore.contactMessages.length.toString(),
                icon: Icons.chat_bubble_outline_rounded,
                color: const Color(0xFFFF6B6B),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Direct Content Management & Updates section
          const Text(
            'Direct Content Management & Updates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Click any section below to directly view, add, or update live portfolio content.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildQuickActionCard(
                title: 'Update Projects',
                subtitle:
                    '${firestore.projects.length} portfolio items configured',
                icon: Icons.rocket_launch_rounded,
                color: const Color(0xFF64FFDA),
                buttonText: 'Update Projects',
                onTap: () => _tabController.animateTo(1),
              ),
              _buildQuickActionCard(
                title: 'Update Experience',
                subtitle:
                    '${firestore.experiences.length} career positions recorded',
                icon: Icons.business_center_rounded,
                color: const Color(0xFF7B68EE),
                buttonText: 'Update Experience',
                onTap: () => _tabController.animateTo(2),
              ),
              _buildQuickActionCard(
                title: 'Update Skills',
                subtitle:
                    '${firestore.techCategories.length} categories & technology badges',
                icon: Icons.psychology_rounded,
                color: const Color(0xFFFFD700),
                buttonText: 'Update Skills',
                onTap: () => _tabController.animateTo(3),
              ),
              _buildQuickActionCard(
                title: 'Update About & Approach',
                subtitle:
                    '${firestore.aboutCards.length} value cards · ${firestore.approachPhases.length} methodology phases',
                icon: Icons.info_outline_rounded,
                color: const Color(0xFF00E5FF),
                buttonText: 'Update About & Approach',
                onTap: () => _tabController.animateTo(4),
              ),
              _buildQuickActionCard(
                title: 'Update Profile & Contact',
                subtitle: 'Name, titles, bio, resume link, socials & footer',
                icon: Icons.person_outline_rounded,
                color: const Color(0xFFF472B6),
                buttonText: 'Update Profile Info',
                onTap: () => _tabController.animateTo(5),
              ),
              _buildQuickActionCard(
                title: 'Visitor Inquiries',
                subtitle:
                    '${firestore.contactMessages.length} messages received from contact form',
                icon: Icons.mark_email_unread_rounded,
                color: const Color(0xFFFF6B6B),
                buttonText: 'View Messages',
                onTap: () => _tabController.animateTo(6),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Database Sync Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.cloud_upload_rounded,
                      color: AppColors.accent, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'One-Click Firestore Seeding & Sync',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Populate or reset your Firestore database with the comprehensive portfolio defaults (projects, experiences, skills, about cards, and contact info). Existing collections won\'t be duplicated unless you choose to overwrite.',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          Obx(() => ElevatedButton.icon(
                                onPressed: firestore.isSeeding.value
                                    ? null
                                    : () => _confirmSeed(context),
                                icon: firestore.isSeeding.value
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.black),
                                      )
                                    : const Icon(Icons.sync, size: 18),
                                label: Text(
                                  firestore.isSeeding.value
                                      ? 'Syncing to Firestore...'
                                      : 'Seed / Sync All Data',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                ),
                              )),
                          Obx(() => OutlinedButton.icon(
                                onPressed: firestore.isMigratingImages.value
                                    ? null
                                    : _migrateImages,
                                icon: firestore.isMigratingImages.value
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.accent),
                                      )
                                    : const Icon(Icons.image_outlined,
                                        size: 18),
                                label: Text(
                                  firestore.isMigratingImages.value
                                      ? 'Uploading images...'
                                      : 'Move Images to Firestore',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.accent,
                                  side:
                                      const BorderSide(color: AppColors.accent),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
              ),
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward_rounded, size: 14),
              label: Text(buttonText,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withValues(alpha: 0.15),
                foregroundColor: color,
                side: BorderSide(color: color.withValues(alpha: 0.4)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openProjectDialog([Project? project]) {
    final firestore = FirestoreService.to;
    showDialog(
      context: context,
      builder: (ctx) => ProjectDialog(
        project: project,
        onSave: (p) async {
          if (project == null) {
            await firestore.createProject(p);
            _showMessage('Project "${p.title}" created successfully!');
          } else {
            await firestore.updateProject(p);
            _showMessage(
                'Project "${p.title}" updated successfully in Firestore!');
          }
        },
      ),
    );
  }

  void _openExperienceDialog([Experience? experience]) {
    final firestore = FirestoreService.to;
    showDialog(
      context: context,
      builder: (ctx) => ExperienceDialog(
        experience: experience,
        onSave: (e) async {
          if (experience == null) {
            await firestore.createExperience(e);
            _showMessage('Experience "${e.company}" created successfully!');
          } else {
            await firestore.updateExperience(e);
            _showMessage(
                'Experience "${e.company}" updated successfully in Firestore!');
          }
        },
      ),
    );
  }

  void _openTechCategoryDialog([TechCategory? category]) {
    final firestore = FirestoreService.to;
    showDialog(
      context: context,
      builder: (ctx) => TechCategoryDialog(
        category: category,
        onSave: (c) async {
          if (category == null) {
            await firestore.createTechCategory(c);
            _showMessage('Skill category "${c.title}" added successfully!');
          } else {
            await firestore.updateTechCategory(c);
            _showMessage(
                'Skill category "${c.title}" updated successfully in Firestore!');
          }
        },
      ),
    );
  }

  void _openAboutCardDialog([AboutCard? card]) {
    final firestore = FirestoreService.to;
    showDialog(
      context: context,
      builder: (ctx) => AboutCardDialog(
        card: card,
        onSave: (c) async {
          if (card == null) {
            await firestore.createAboutCard(c);
            _showMessage('About card "${c.title}" added successfully!');
          } else {
            await firestore.updateAboutCard(c);
            _showMessage(
                'About card "${c.title}" updated successfully in Firestore!');
          }
        },
      ),
    );
  }

  void _openApproachPhaseDialog([ApproachPhase? phase]) {
    final firestore = FirestoreService.to;
    showDialog(
      context: context,
      builder: (ctx) => ApproachPhaseDialog(
        phase: phase,
        onSave: (p) async {
          if (phase == null) {
            await firestore.createApproachPhase(p);
            _showMessage('Approach phase "${p.title}" added successfully!');
          } else {
            await firestore.updateApproachPhase(p);
            _showMessage(
                'Approach phase "${p.title}" updated successfully in Firestore!');
          }
        },
      ),
    );
  }

  // ==========================================
  // TAB 2: PROJECTS
  // ==========================================
  Widget _buildProjectsTab() {
    final firestore = FirestoreService.to;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Projects Portfolio',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click any project card or press "Update / Edit" to modify details live in Firestore.',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _openProjectDialog(),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (firestore.projects.isEmpty) {
                return const Center(
                  child: Text(
                    'No projects found in Firestore. Click "Seed Firestore" or "Add Project" to get started.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              return ListView.separated(
                itemCount: firestore.projects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final p = firestore.projects[index];
                  return Material(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _openProjectDialog(p),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '#${p.order}',
                                style: const TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        p.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      if (p.category != null) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            p.category!,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.accent),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    p.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    children: p.technologies
                                        .take(5)
                                        .map((t) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                        AppColors.glassBorder),
                                              ),
                                              child: Text(
                                                t,
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: AppColors
                                                        .textSecondary),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.edit_note_rounded,
                                      size: 16),
                                  label: const Text(
                                    'Update / Edit',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent
                                        .withValues(alpha: 0.18),
                                    foregroundColor: AppColors.accent,
                                    side: const BorderSide(
                                        color: AppColors.accent, width: 1.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    elevation: 0,
                                  ),
                                  onPressed: () => _openProjectDialog(p),
                                ),
                                const SizedBox(height: 6),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      size: 14, color: Colors.redAccent),
                                  label: const Text('Delete',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 11)),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: Colors.redAccent
                                            .withValues(alpha: 0.4)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                  ),
                                  onPressed: () => _confirmDelete(
                                    context,
                                    'Delete Project',
                                    'Are you sure you want to delete "${p.title}"?',
                                    () async {
                                      if (p.id != null) {
                                        await firestore.deleteProject(p.id!);
                                        _showMessage('Project deleted.');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 3: EXPERIENCES
  // ==========================================
  Widget _buildExperienceTab() {
    final firestore = FirestoreService.to;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work Experience',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click any experience card or press "Update / Edit" to modify positions, dates, or tech live.',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _openExperienceDialog(),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Experience'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (firestore.experiences.isEmpty) {
                return const Center(
                  child: Text(
                    'No experiences found in Firestore.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              return ListView.separated(
                itemCount: firestore.experiences.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final e = firestore.experiences[index];
                  return Material(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _openExperienceDialog(e),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B68EE)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.work_outline,
                                  color: Color(0xFF7B68EE), size: 22),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${e.position} · ${e.company}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${e.duration} | ${e.location ?? "Remote"} | ${e.type ?? "Full-time"}',
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.accent),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    e.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.edit_note_rounded,
                                      size: 16),
                                  label: const Text(
                                    'Update / Edit',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7B68EE)
                                        .withValues(alpha: 0.18),
                                    foregroundColor: const Color(0xFF7B68EE),
                                    side: const BorderSide(
                                        color: Color(0xFF7B68EE), width: 1.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    elevation: 0,
                                  ),
                                  onPressed: () => _openExperienceDialog(e),
                                ),
                                const SizedBox(height: 6),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      size: 14, color: Colors.redAccent),
                                  label: const Text('Delete',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 11)),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: Colors.redAccent
                                            .withValues(alpha: 0.4)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                  ),
                                  onPressed: () => _confirmDelete(
                                    context,
                                    'Delete Experience',
                                    'Delete experience at "${e.company}"?',
                                    () async {
                                      if (e.id != null) {
                                        await firestore.deleteExperience(e.id!);
                                        _showMessage('Experience deleted.');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 4: SKILLS & CATEGORIES
  // ==========================================
  Widget _buildSkillsTab() {
    final firestore = FirestoreService.to;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Skill Categories & Technologies',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click any skill card or press "Update / Edit" to modify category titles, skills, or color badges.',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _openTechCategoryDialog(),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Category'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (firestore.techCategories.isEmpty) {
                return const Center(
                  child: Text(
                    'No skill categories found in Firestore.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 440,
                  mainAxisExtent: 220,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: firestore.techCategories.length,
                itemBuilder: (context, index) {
                  final cat = firestore.techCategories[index];
                  final catColor = Color(cat.color);

                  return Material(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _openTechCategoryDialog(cat),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: catColor.withValues(alpha: 0.35)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: catColor, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cat.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.edit_note_rounded,
                                      size: 14),
                                  label: const Text('Update / Edit',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        catColor.withValues(alpha: 0.18),
                                    foregroundColor: catColor,
                                    side: BorderSide(color: catColor, width: 1),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    elevation: 0,
                                  ),
                                  onPressed: () => _openTechCategoryDialog(cat),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18, color: Colors.redAccent),
                                  onPressed: () => _confirmDelete(
                                    context,
                                    'Delete Category',
                                    'Delete "${cat.title}" category?',
                                    () async {
                                      if (cat.id != null) {
                                        await firestore
                                            .deleteTechCategory(cat.id!);
                                        _showMessage('Category deleted.');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: AppColors.glassBorder),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: cat.skills
                                      .map((skill) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: catColor.withValues(
                                                  alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: catColor.withValues(
                                                      alpha: 0.25)),
                                            ),
                                            child: Text(
                                              skill,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: catColor),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 5: ABOUT & APPROACH
  // ==========================================
  Widget _buildAboutApproachTab() {
    final firestore = FirestoreService.to;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About cards header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Section Cards',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click any card or press "Update / Edit" to modify title, icon, or description.',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _openAboutCardDialog(),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: firestore.aboutCards.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final card = firestore.aboutCards[i];
                  return Material(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _openAboutCardDialog(card),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(card.icon,
                                  style: const TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(card.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                          fontSize: 15)),
                                  const SizedBox(height: 2),
                                  Text(card.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              icon:
                                  const Icon(Icons.edit_note_rounded, size: 15),
                              label: const Text('Update / Edit',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.accent.withValues(alpha: 0.18),
                                foregroundColor: AppColors.accent,
                                side: const BorderSide(
                                    color: AppColors.accent, width: 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                elevation: 0,
                              ),
                              onPressed: () => _openAboutCardDialog(card),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.redAccent),
                              onPressed: () => _confirmDelete(
                                context,
                                'Delete About Card',
                                'Delete "${card.title}"?',
                                () async {
                                  if (card.id != null) {
                                    await firestore.deleteAboutCard(card.id!);
                                    _showMessage('Card deleted.');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),

          const SizedBox(height: 36),

          // Approach phases header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Approach Methodology Phases',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Click any phase or press "Update / Edit" to modify title, duration, or key bullet points.',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _openApproachPhaseDialog(),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add Phase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: firestore.approachPhases.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final phase = firestore.approachPhases[i];
                  return Material(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _openApproachPhaseDialog(phase),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(phase.icon,
                                  style: const TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${phase.title} (${phase.duration})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                          fontSize: 15)),
                                  const SizedBox(height: 2),
                                  Text(phase.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              icon:
                                  const Icon(Icons.edit_note_rounded, size: 15),
                              label: const Text('Update / Edit',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00E5FF)
                                    .withValues(alpha: 0.18),
                                foregroundColor: const Color(0xFF00E5FF),
                                side: const BorderSide(
                                    color: Color(0xFF00E5FF), width: 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                elevation: 0,
                              ),
                              onPressed: () => _openApproachPhaseDialog(phase),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.redAccent),
                              onPressed: () => _confirmDelete(
                                context,
                                'Delete Approach Phase',
                                'Delete "${phase.title}"?',
                                () async {
                                  if (phase.id != null) {
                                    await firestore
                                        .deleteApproachPhase(phase.id!);
                                    _showMessage('Phase deleted.');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 6: PROFILE & CONTACTS
  // ==========================================
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: Form(
          key: _profileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Action Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile & Live Portfolio Info',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Directly edit and update your hero section, bio, socials, and footer live in Firestore.',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          final info = FirestoreService.to.profileInfo.value;
                          _populateProfileControllers(info);
                          _showMessage(
                              'Form reloaded with live database values.');
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: const Text('Reload Live Values'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(color: AppColors.glassBorder),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _saveProfile,
                        icon: const Icon(Icons.cloud_upload_rounded, size: 18),
                        label: const Text('Update Profile & Publish Live'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Live Sync Notification Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.35)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.greenAccent, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Live Website Sync Active: Any updates saved here immediately reflect across your live website (Hero, Bio, Experience stats, Resume, Socials, and Footer).',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 13,
                            height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Personal & Hero Information',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),

              _buildInputField(controller: _nameCtrl, label: 'Full Name *'),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _titleCtrl,
                  label: 'Professional Title (e.g. Forward Deployed Engineer)',
                  maxLines: 2),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _subtitleCtrl,
                  label: 'Hero Subtitle',
                  maxLines: 2),
              const SizedBox(height: 12),
              _buildInputField(controller: _taglineCtrl, label: 'Tagline'),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _descCtrl,
                  label: 'Hero / Bio Description',
                  maxLines: 4),
              const SizedBox(height: 12),

              // Animated Typing Words
              _buildInputField(
                controller: _typingWordsCtrl,
                label: 'Hero Animated Typing Roles (comma-separated)',
                hint:
                    'Forward Deployed Engineer, Implementation Lead, AI Platform Specialist',
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          controller: _locationCtrl,
                          label: 'Location (e.g. Remote, Worldwide)')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          controller: _availabilityCtrl,
                          label:
                              'Availability Status (e.g. Available for opportunities)')),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          controller: _yearsExpCtrl,
                          label: 'Years of Experience (e.g. 8+)')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          controller: _completedProjectsCtrl,
                          label: 'Completed Projects (e.g. 20+)')),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Profile Photo',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: AppImage(
                      _profileImageCtrl.text.trim(),
                      fallbackAsset: 'assets/images/profile.png',
                      width: 72,
                      height: 72,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _profileImageCtrl.text.isEmpty
                          ? 'Using the default photo bundled with the site.'
                          : ImageService.isDataUrl(_profileImageCtrl.text)
                              ? 'Custom photo stored in Firestore.'
                              : _profileImageCtrl.text,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ),
                  if (_profileImageCtrl.text.isNotEmpty)
                    IconButton(
                      tooltip: 'Use default photo',
                      onPressed: () =>
                          setState(() => _profileImageCtrl.clear()),
                      icon: const Icon(Icons.close,
                          size: 18, color: AppColors.textSecondary),
                    ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: _isUploadingPhoto ? null : _uploadProfilePhoto,
                    icon: _isUploadingPhoto
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.accent),
                          )
                        : const Icon(Icons.cloud_upload_outlined, size: 18),
                    label: Text(_isUploadingPhoto ? 'Uploading...' : 'Upload'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Resume & External URLs',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _cvUrlCtrl,
                      label: 'Resume / CV Download URL',
                      hint: 'https://... or assets/resume.pdf',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      controller: _portfolioUrlCtrl,
                      label: 'Live Portfolio URL',
                      hint:
                          'https://abbasv0786.github.io/portfolio/#/ahemadabbas-vagh',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Contact Details & Social Links',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          controller: _emailContactCtrl,
                          label: 'Email Address')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          controller: _phoneCtrl, label: 'Phone Number')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          controller: _whatsappCtrl, label: 'WhatsApp Number')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          controller: _telegramCtrl, label: 'Telegram Handle')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _buildInputField(
                          controller: _discordCtrl, label: 'Discord Username')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildInputField(
                          controller: _githubCtrl,
                          label: 'GitHub Profile URL')),
                ],
              ),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _linkedinCtrl, label: 'LinkedIn Profile URL'),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _twitterCtrl, label: 'Twitter / X Profile URL'),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _instagramCtrl, label: 'Instagram Profile URL'),

              const SizedBox(height: 24),
              const Text(
                'Footer Content',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _footerDescCtrl,
                  label: 'Footer Bio / Description',
                  maxLines: 3),
              const SizedBox(height: 12),
              _buildInputField(
                  controller: _footerCopyrightCtrl,
                  label: 'Footer Copyright Notice'),

              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.cloud_upload_rounded, size: 20),
                label: const Text(
                  'Update Profile & Publish Live',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadProfilePhoto() async {
    setState(() => _isUploadingPhoto = true);
    try {
      final dataUrl = await ImageService.pickImageAsDataUrl(maxWidth: 800);
      if (dataUrl == null) return;
      setState(() => _profileImageCtrl.text = dataUrl);
      _showMessage('Photo ready. Click "Update Profile" to publish it.');
    } catch (e) {
      _showMessage(
          'Photo upload failed: ${e.toString().replaceFirst('Exception: ', '')}',
          isError: true);
    } finally {
      if (mounted) setState(() => _isUploadingPhoto = false);
    }
  }

  Future<void> _migrateImages() async {
    try {
      final moved = await FirestoreService.to.migrateImagesToFirestore();
      _showMessage(moved == 0
          ? 'All images are already stored in Firestore.'
          : 'Moved $moved image(s) into Firestore.');
    } catch (e) {
      _showMessage('Image migration failed: $e', isError: true);
    }
  }

  void _saveProfile() async {
    final current = FirestoreService.to.profileInfo.value;
    final updated = current.copyWith(
      name: _nameCtrl.text.trim(),
      title: _titleCtrl.text.trim(),
      subtitle: _subtitleCtrl.text.trim(),
      tagline: _taglineCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      availability: _availabilityCtrl.text.trim(),
      yearsOfExperience: _yearsExpCtrl.text.trim(),
      completedProjects: _completedProjectsCtrl.text.trim(),
      email: _emailContactCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      whatsapp: _whatsappCtrl.text.trim(),
      telegram: _telegramCtrl.text.trim(),
      discord: _discordCtrl.text.trim(),
      github: _githubCtrl.text.trim(),
      linkedin: _linkedinCtrl.text.trim(),
      twitter: _twitterCtrl.text.trim(),
      instagram: _instagramCtrl.text.trim(),
      cvUrl: _cvUrlCtrl.text.trim(),
      profileImageUrl: _profileImageCtrl.text.trim(),
      portfolioUrl: _portfolioUrlCtrl.text.trim(),
      footerDescription: _footerDescCtrl.text.trim(),
      footerCopyright: _footerCopyrightCtrl.text.trim(),
      typingWords: _typingWordsCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
    );

    try {
      await FirestoreService.to.updateProfileInfo(updated);
      _showMessage('Profile updated successfully! Live website refreshed.');
    } catch (e) {
      _showMessage('Error updating profile: $e', isError: true);
    }
  }

  // ==========================================
  // TAB 7: MESSAGES
  // ==========================================
  Widget _buildMessagesTab() {
    final firestore = FirestoreService.to;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inquiries from Portfolio Contact Form',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (firestore.contactMessages.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined,
                          size: 48, color: AppColors.textSecondary),
                      SizedBox(height: 12),
                      Text(
                        'No visitor inquiries yet.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: firestore.contactMessages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final msg = firestore.contactMessages[i];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: msg.isRead
                            ? AppColors.glassBorder
                            : AppColors.accent.withValues(alpha: 0.5),
                        width: msg.isRead ? 1 : 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: msg.isRead
                                    ? Colors.white10
                                    : AppColors.accent.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                msg.isRead ? 'Read' : 'New Message',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: msg.isRead
                                      ? AppColors.textSecondary
                                      : AppColors.accent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              msg.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '<${msg.email}>',
                              style: const TextStyle(
                                  fontSize: 13, color: AppColors.textSecondary),
                            ),
                            const Spacer(),
                            Text(
                              '${msg.createdAt.day}/${msg.createdAt.month}/${msg.createdAt.year} ${msg.createdAt.hour}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          msg.message,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                              height: 1.4),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                if (msg.id != null) {
                                  firestore.markMessageAsRead(
                                      msg.id!, !msg.isRead);
                                }
                              },
                              icon: Icon(
                                msg.isRead
                                    ? Icons.mark_email_unread_outlined
                                    : Icons.mark_email_read_outlined,
                                size: 16,
                                color: AppColors.accent,
                              ),
                              label: Text(
                                msg.isRead ? 'Mark as Unread' : 'Mark as Read',
                                style: const TextStyle(
                                    color: AppColors.accent, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.redAccent),
                              onPressed: () {
                                if (msg.id != null) {
                                  firestore.deleteContactMessage(msg.id!);
                                  _showMessage('Message deleted');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // HELPER DIALOGS & WIDGETS
  // ==========================================
  void _confirmSeed(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCard,
        title: const Text('Seed Firestore Database',
            style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          'Do you want to sync the default portfolio data to Firestore?\n\n'
          '• Standard Sync: Inserts data if collections are empty (safe, will not overwrite your edits).\n'
          '• Overwrite Sync: Resets all collections to the default initial values.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          OutlinedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await FirestoreService.to.seedDefaultData(overwrite: true);
              _showMessage(
                  'Firestore reset & seeded successfully with defaults!');
            },
            style:
                OutlinedButton.styleFrom(foregroundColor: Colors.orangeAccent),
            child: const Text('Overwrite All'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await FirestoreService.to.seedDefaultData(overwrite: false);
              _showMessage('Firestore synchronized successfully!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.black,
            ),
            child: const Text('Standard Sync'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String title, String content,
      VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCard,
        title:
            Text(title, style: const TextStyle(color: AppColors.textPrimary)),
        content: Text(content,
            style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool isPassword = false,
    IconData? prefixIcon,
    Widget? suffixIcon,
    int maxLines = 1,
    TextInputAction? textInputAction,
    void Function(String)? onSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.accent, size: 20)
            : null,
        suffixIcon: suffixIcon,
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        hintStyle: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.4),
            fontSize: 13),
        filled: true,
        fillColor: AppColors.background.withValues(alpha: 0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}
