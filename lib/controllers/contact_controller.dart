import 'package:get/get.dart';

class ContactController extends GetxController {
  // Form fields
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString message = ''.obs;

  // Form validation states
  final RxBool isNameValid = true.obs;
  final RxBool isEmailValid = true.obs;
  final RxBool isMessageValid = true.obs;

  // Form submission states
  final RxBool isSubmitting = false.obs;
  final RxBool isSubmitted = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Removed unused animation states - form is always visible

  // Methods
  void setName(String value) {
    name.value = value;
    validateName();
  }

  void setEmail(String value) {
    email.value = value;
    validateEmail();
  }

  void setMessage(String value) {
    message.value = value;
    validateMessage();
  }

  void validateName() {
    isNameValid.value = name.value.trim().isNotEmpty;
    update();
  }

  void validateEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isEmailValid.value = emailRegex.hasMatch(email.value.trim());
    update();
  }

  void validateMessage() {
    isMessageValid.value = message.value.trim().length >= 10;
    update();
  }

  bool get isFormValid {
    return isNameValid.value && isEmailValid.value && isMessageValid.value;
  }

  Future<void> submitForm() async {
    if (!isFormValid) {
      validateName();
      validateEmail();
      validateMessage();
      return;
    }

    isSubmitting.value = true;
    hasError.value = false;
    errorMessage.value = '';
    update();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success
      isSubmitted.value = true;
      update();
      clearForm();

      // Reset success state after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        isSubmitted.value = false;
        update();
      });
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to send message. Please try again.';
      update();
    } finally {
      isSubmitting.value = false;
      update();
    }
  }

  void clearForm() {
    name.value = '';
    email.value = '';
    message.value = '';
    isNameValid.value = true;
    isEmailValid.value = true;
    isMessageValid.value = true;
  }

  // Removed unused animation methods - form is always visible
}
