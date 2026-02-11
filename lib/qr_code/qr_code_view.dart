import 'dart:nativewrappers/_internal/vm/lib/developer.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/qr_code/models/redeemed_ticket.dart';
import 'package:scanner_app/qr_code/qr_code_controller.dart';
class QRCodeView extends StatefulWidget {
  const QRCodeView({super.key});

  @override
  State<QRCodeView> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  late final QRCodeController controller = QRCodeController(
    onSuccess: (code) {
      log('Scan success: $code');
      // Logic handled in _onDetect await
    },
    onError: (error) {
      log('Scan error: $error');
    },
  );
  bool isScanning = false;

  void _onDetect(BarcodeCapture capture) async {
    if (isScanning) return;

    final code = capture.barcodes.first.rawValue;
    if (code == null) return;

    isScanning = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await controller.redeemQRCode(code);

    if (!mounted) return;

    Navigator.pop(context); // close loading

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(success ? 'Berhasil' : 'Gagal'),
        content: Text(
          success
              ? 'Ticket berhasil diredeem'
              : 'QR tidak valid atau sudah digunakan',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(
                context,
                RedeemedTicket(name: 'Guest Event', code: code, isRedeemed: true),
              ); // balik ke home
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Scan Ticket'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          /// CAMERA
          MobileScanner(onDetect: _onDetect),

          /// DARK OVERLAY
          Container(color: Colors.black.withValues(alpha: 0.5)),

          /// SCAN BOX
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.greenAccent, width: 3),
              ),
            ),
          ),

          /// TEXT HINT
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  'Arahkan QR ke dalam kotak',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Scanning otomatis',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}