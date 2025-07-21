import 'package:get/get.dart';
import '../data/portfolio_data.dart';
import '../models/about_card.dart';
import '../models/tech_category.dart';

class AboutController extends GetxController {
  final RxInt hoveredIndex = (-1).obs;
  final RxBool isSkillsAnimated = false.obs;
  final RxDouble skillsAnimationProgress = 0.0.obs;
  final RxBool isProfileHovered = false.obs;

  // Get about cards from PortfolioData
  List<AboutCard> get aboutCards => PortfolioData.aboutCards;

  // Tech stack categories
  final RxList<TechCategory> techCategories = [
    const TechCategory(
      title: 'Frontend',
      skills: [
        'iOS',
        'Swift',
        'Flutter',
        'Dart',
        'Objective-C',
        'Android',
        'Cordova',
        'React Native',
        'HTML/CSS',
        'JavaScript',
        '...and a range of other'
      ],
      color: 0xFF64FFDA,
    ),
    const TechCategory(
      title: 'Backend',
      skills: [
        'Node.js',
        'Python',
        'Django',
        'FastAPI',
        'LLM APIs',
        '...and a range of other'
      ],
      color: 0xFF7B68EE,
    ),
    const TechCategory(
      title: 'Database',
      skills: [
        'Relational: PostgreSQL, MySQL',
        'NoSQL: MongoDB, Firebase Realtime, Firestore',
        'Vector: Pinecone',
        '...and a range of other'
      ],
      color: 0xFFFF6B6B,
    ),
    const TechCategory(
      title: 'Tools & Others',
      skills: [
        'Git',
        'Docker',
        'AWS',
        'CI/CD',
        'Source Tree',
        'Figma',
        'InVision',
        'XCode',
        'Android Studio',
        'VS Code',
        'n8n',
        'Cursor',
        '...and a range of other'
      ],
      color: 0xFF4ECDC4,
    ),
  ].obs;

  // Methods
  void setCardHovered(int index, bool value) {
    hoveredIndex.value = value ? index : -1;
    update();
  }

  void setProfileHovered(bool value) {
    isProfileHovered.value = value;
    update();
  }

  void startSkillsAnimation() async {
    isSkillsAnimated.value = true;
    for (double i = 0.0; i <= 1.0; i += 0.02) {
      skillsAnimationProgress.value = i;
      await Future.delayed(const Duration(milliseconds: 30));
    }
    isSkillsAnimated.value = false;
  }

  bool isCardHovered(int index) {
    return hoveredIndex.value == index;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize hover states
    for (var i = 0; i < aboutCards.length; i++) {
      // cardHoverStates[i] = false; // This line is removed as per the new_code
    }
    // Start skills animation
    Future.delayed(const Duration(milliseconds: 500), () {
      startSkillsAnimation();
    });
  }
}
