import 'package:flutter/material.dart';
import 'package:scanner_app/auth/login/login_view.dart';
import 'package:scanner_app/auth/register/register_view.dart';
import 'qr_code/qr_code_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Pass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/scan-qr': (_) => const QRCodeView(),

      },
    );
  }
}
