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
  bool isScanning = false;

  late final QRCodeController controller = QRCodeController();

  /// HANDLE QR DETECT
  Future<void> _onDetect(BarcodeCapture capture) async {
    if (isScanning) return;
    if (capture.barcodes.isEmpty) return;

    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    isScanning = true;

    /// Loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final bool success = await controller.redeemQRCode(code);

    if (!mounted) return;

    Navigator.pop(context); // close loading

    /// Result dialog
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
              isScanning = false;

              if (success) {
                Navigator.pop(
                  context,
                  RedeemedTicket(
                    name: 'Guest Event',
                    code: code,
                    isRedeemed: true,
                  ),
                );
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
        alignment: Alignment.center,
        children: [
          /// CAMERA
          MobileScanner(
            onDetect: _onDetect,
            fit: BoxFit.cover,
          ),

          /// DARK OVERLAY
          IgnorePointer(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          /// SCAN BOX
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.greenAccent,
                width: 3,
              ),
            ),
          ),

          /// TEXT HINT
          Positioned(
            bottom: 80,
            child: Column(
              children: const [
                Text(
                  'Arahkan QR ke dalam kotak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Scanning otomatis',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}