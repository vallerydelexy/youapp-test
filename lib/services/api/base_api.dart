import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseApi {
  late Dio dio;
  BaseApi() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://techtest.youapp.ai/',
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 300 * 1000),
        receiveTimeout: const Duration(milliseconds: 300 * 1000),
      ),
    )..interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
      ));
  }

  Future<String> authToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  }

  ErrorApi errorHandler(DioException error) {
    String errorMessage = 'An unknown error occurred';
    int? errorCode;

    if (error.type == DioExceptionType.connectionTimeout) {
      return ErrorApi(message: 'Connect timeout', errorCode: -1);
    }
    if (error.type == DioExceptionType.receiveTimeout) {
      return ErrorApi(message: 'Receive timeout', errorCode: -1);
    }

    if (error.response != null) {
      errorCode = error.response?.statusCode;
      try {
        final Map<String, dynamic> errorData = json.decode(error.response.toString());
        errorMessage = errorData['message'] ?? errorMessage;
      } catch (_) {
        errorMessage = error.response?.statusMessage ?? errorMessage;
      }
    } else {
      errorMessage = error.message ?? errorMessage;
    }

    return ErrorApi(message: errorMessage, errorCode: errorCode);
  }
}

class RespApi {
  RespApi({
    this.message,
    this.data,
  });

  RespApi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  dynamic data;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

class ErrorApi {
  ErrorApi({this.message, this.errorCode});

  ErrorApi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errorCode = json['errorCode'] ?? -1;
  }

  int? errorCode;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['errorCode'] = errorCode;
    return data;
  }
}
