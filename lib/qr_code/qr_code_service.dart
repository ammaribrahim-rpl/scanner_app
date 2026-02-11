import 'package:dio/dio.dart';
import 'dart:developer' show log;

class QrCodeService {
  static const String _baseUrl = 'https://event-ticketing-ruddy.vercel.app';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// Scan / Redeem ticket by QR code
  Future<bool> scanTicket(String qrData) async {
    try {
      log('Sending QR to backend: $qrData');

      final response = await _dio.post(
        '/api/scan',
        data: {
          'qr_data': qrData, // 🔥 SAMA PERSIS kayak backend
        },
      );

      log('Response Status: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        log('✅ QR Code redeemed successfully');
        return true;
      } else {
        log('⚠️ Failed to redeem QR Code');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log('❌ Dio Error: ${e.response?.data}');
      } else {
        log('❌ Network Error: ${e.message}');
      }
      return false;
    } catch (e) {
      log('❌ Unexpected Error: $e');
      return false;
    }
  }
}