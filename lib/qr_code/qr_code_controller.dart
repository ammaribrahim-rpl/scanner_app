import 'dart:developer' show log;

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/qr_code/qr_code_service.dart';

class QRCodeController {
  final QrCodeService service = QrCodeService();
  bool _isScanning = false;
  final Function(String) onSuccess;
  final Function(String) onError;

  QRCodeController({required this.onSuccess, required this.onError});

  void scanQRCode(BarcodeCapture barcodes) {
    if (_isScanning) return;
    
    final barcode = barcodes.barcodes.first.rawValue;
    log('Barcode found!: $barcode');
    
    if (barcode != null) {
      _isScanning = true;
      redeemQRCode(barcode).whenComplete(() {
        // Add a small delay before allowing another scan to prevent accidental double-scans
        Future.delayed(const Duration(seconds: 2), () {
          _isScanning = false;
        });
      });
    }
  }

  Future<void> redeemQRCode(String qrData) async {
    log('Redeeming QR Code : $qrData');
    try {
      await service.scanTicket(qrData);
      log('Successfully redeemed ticket: $qrData');
      onSuccess(qrData);
    } catch (e) {
      log('Failed to redeem ticket: $e');
      onError(e.toString());
    }
  }
}
