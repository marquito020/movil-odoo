// lib/config/dio_config.dart
import 'package:dio/dio.dart';

class DioConfig {
  //   static const String baseUrl = 'http://10.0.2.2:5000';
  // static const String baseUrl = 'http://192.168.0.202:4000';
  static const String baseUrl = 'http://192.241.150.219:8069';

  static const String contentType = 'application/json; charset=UTF-8';

  static final dioWithoutAuthorization = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'login': 'admin',
      'password': 'admin',
      'api-key': '6b157658-5b1d-4142-a14d-a15828197ff5',
    },
    contentType: contentType,
  ));
}
