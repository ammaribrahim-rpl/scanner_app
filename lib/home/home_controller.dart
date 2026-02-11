import 'package:flutter/material.dart';

class HomeController {
  void goToScanQR(BuildContext context) {
    Navigator.pushNamed(context, '/scan-qr');
  }

  void logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }
}