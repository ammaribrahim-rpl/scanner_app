import 'package:flutter/material.dart';
import 'register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = RegisterController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: controller.fullNameController, decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(controller: controller.usernameController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: controller.passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            TextField(controller: controller.confirmPasswordController, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
            const SizedBox(height: 16),

            ValueListenableBuilder<String?>(
              valueListenable: controller.errorMessage,
              builder: (_, error, __) {
                if (error == null) return const SizedBox.shrink();
                return Text(error, style: const TextStyle(color: Colors.red));
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final success = await controller.register();
                if (!mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Register success, please login')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}