import 'package:dio/dio.dart';
import 'package:sunshine_app/config/app_config.dart';

final DioService dioService = DioService();

class DioService {
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  late Dio dio;

  DioService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }
}
