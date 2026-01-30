
import 'package:flutter/material.dart';
import 'package:scanner_app/qr_code/qr_code_view.dart';

class HomeController {
  void goToscanQRCodeView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeView()));
  }

  void logout(BuildContext context) {
    // Navigate back to LoginView and remove all previous routes
    // We need to import LoginView, but since it's a circular dependency potentially if structured poorly,
    // let's check imports. Actually, we can just pushReplacement to Login (or pop until root if Main is Login).
    // However, Main will be LoginView, so we probably want to restart or pushReplacement to LoginView.
    // Let's assume we pushReplacement to LoginView.
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
