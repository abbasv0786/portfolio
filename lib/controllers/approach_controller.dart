import 'package:get/get.dart';
import '../models/approach_phase.dart';
import '../services/firestore_service.dart';

class ApproachController extends GetxController {
  // Hover states
  final RxInt hoveredIndex = (-1).obs;

  // Animation states
  final RxBool showContent = false.obs;

  // Timeline animation
  final RxDouble timelineProgress = 0.0.obs;

  // Approach phases dynamic list from FirestoreService
  RxList<ApproachPhase> get approachPhases {
    if (Get.isRegistered<FirestoreService>()) {
      return FirestoreService.to.approachPhases;
    }
    return <ApproachPhase>[].obs;
  }

  // Methods
  void setCardHovered(int index, bool value) {
    hoveredIndex.value = value ? index : -1;
  }

  void toggleCardExpanded(int index) {
    if (index >= 0 && index < approachPhases.length) {
      approachPhases[index].isExpanded.value = !approachPhases[index].isExpanded.value;
      update();
    }
  }

  bool isCardHovered(int index) {
    return hoveredIndex.value == index;
  }

  bool isCardExpanded(int index) {
    if (index >= 0 && index < approachPhases.length) {
      return approachPhases[index].isExpanded.value;
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<FirestoreService>()) {
      ever(FirestoreService.to.approachPhases, (_) => update());
    }
  }
}
