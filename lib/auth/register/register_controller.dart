import 'package:flutter/material.dart';

class RegisterController {
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  Future<bool> register() async {
    isLoading.value = true;
    errorMessage.value = null;

    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match';
      isLoading.value = false;
      return false;
    }

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    return true;
  }

  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}