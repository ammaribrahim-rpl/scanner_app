import 'dart:developer' show log;
import 'package:scanner_app/qr_code/qr_code_service.dart';

class QRCodeController {
  final QrCodeService service = QrCodeService();

  Future<bool> redeemQRCode(String qrData) async {
    log('Redeeming QR Code: $qrData');
    try {
      final success = await service.scanTicket(qrData);
      return success;
    } catch (e) {
      log('Failed to redeem ticket: $e');
      return false;
    }
  }
}