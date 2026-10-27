import 'package:get/get.dart';
import '../models/about_card.dart';
import '../models/tech_category.dart';
import '../services/firestore_service.dart';

class AboutController extends GetxController {
  final RxInt hoveredIndex = (-1).obs;
  final RxBool isSkillsAnimated = false.obs;
  final RxDouble skillsAnimationProgress = 0.0.obs;
  final RxBool isProfileHovered = false.obs;

  // Get about cards dynamically from FirestoreService
  List<AboutCard> get aboutCards {
    if (Get.isRegistered<FirestoreService>()) {
      final list = FirestoreService.to.aboutCards;
      if (list.isNotEmpty) return list;
    }
    return [];
  }

  // Get tech categories dynamically from FirestoreService
  RxList<TechCategory> get techCategories {
    if (Get.isRegistered<FirestoreService>()) {
      return FirestoreService.to.techCategories;
    }
    return <TechCategory>[].obs;
  }

  // Methods
  void setCardHovered(int index, bool value) {
    hoveredIndex.value = value ? index : -1;
  }

  void setProfileHovered(bool value) {
    isProfileHovered.value = value;
    update(['profile']);
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
    if (Get.isRegistered<FirestoreService>()) {
      ever(FirestoreService.to.aboutCards, (_) => update());
      ever(FirestoreService.to.techCategories, (_) => update());
    }

    // Start skills animation
    Future.delayed(const Duration(milliseconds: 500), () {
      startSkillsAnimation();
    });
  }
}
