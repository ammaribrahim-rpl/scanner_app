import 'package:flutter/material.dart';
import 'package:scanner_app/home/home_view.dart';
import 'login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = LoginController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_person, size: 64, color: Colors.deepPurple),
                  const SizedBox(height: 24),

                  TextField(
                    controller: controller.usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 16),

                  ValueListenableBuilder<String?>(
                    valueListenable: controller.errorMessage,
                    builder: (_, error, __) {
                      if (error == null) return const SizedBox.shrink();
                      return Text(error, style: const TextStyle(color: Colors.red));
                    },
                  ),
                  const SizedBox(height: 16),

                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isLoading,
                    builder: (_, loading, __) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  final success = await controller.login();
                                  if (!mounted) return;

                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomeView(
                                          username: controller.usernameController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child: loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Login'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}