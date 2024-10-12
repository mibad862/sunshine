import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/services/dio_service.dart';

final ApiService apiService = ApiService();

class ApiService {
  String authToken = getStringAsync('auth_token');
  // Map header = {'Authorization': 'Bearer $authToken'};

  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  static const serverKey = "3d41895d9c88b284a88103da2ab45cc5";
  Future<dynamic> callPostApi(
      {required String apiPath, apiData, CancelToken? cancelToken}) async {
    try {
      String url = apiPath;
      apiData['serverKey'] = serverKey;
      Response response = await dioService.dio.post(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        }),
        data: apiData,
        cancelToken: cancelToken ?? AppConstants.cancelToken,
      );
      print('api : $apiPath ');
      print('response : ${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        log('call api status is not 200 $url');

        return response.data;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        toast("Something Went Wrong!");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        toast("Connection time out");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        toast("Connection time out");
      }

      log("Dio Exception : $e");

      return e.response?.data;
    }
  }

  Future<dynamic> callGetApi({
    required String apiPath,
    apiData,
    CancelToken? cancelToken,
  }) async {
    try {
      String url = apiPath;
      Response response = await dioService.dio.get(
        url,
        cancelToken: cancelToken ?? AppConstants.cancelToken,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        log('call api status is not 200 $url');
        return response.data;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        toast("Something Went Wrong!");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        toast("Connection time out");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        toast("Connection time out");
      }
      log("Dio Exception : $e");

      return e.response?.data;
    }
  }
}
