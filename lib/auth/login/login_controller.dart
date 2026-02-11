import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  // Dummy akun (simulasi backend)
  final String _dummyUsername = 'user123';
  final String _dummyPassword = 'password123';

  Future<bool> login() async {
    isLoading.value = true;
    errorMessage.value = null;

    await Future.delayed(const Duration(seconds: 2));

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = false;

    if (username == _dummyUsername && password == _dummyPassword) {
      return true;
    } else {
      errorMessage.value = 'Invalid username or password';
      return false;
    }
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}