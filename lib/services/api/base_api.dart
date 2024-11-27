import 'dart:convert';

import 'package:dio/dio.dart';


import '../../utils/preferences.dart';
import '../../views/routes.dart';

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


  ErrorApi errorHandler(DioException error) {
    // Note: DioException is now DioException
    if (error.type == DioExceptionType.connectionTimeout) {
      return ErrorApi.fromJson({'message': 'Connect timeout'});
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      return ErrorApi.fromJson({'message': 'Receive timeout'});
    }

    if (error.type == DioExceptionType.badResponse) {
      // Changed from response to badResponse
      final err = ErrorApi.fromJson(json.decode(error.response.toString()));
      if (err.message != '') {
        // if (err.message?.toLowerCase() == 'unauthorized') {
        //   Future.delayed(const Duration(milliseconds: 500), () {
        //     navKey.currentState?.pushReplacementNamed(Routes.login);
        //   });
        // }

        return ErrorApi.fromJson({'message': err.message});
      }
    }

    if (error.response == null) {
      return ErrorApi.fromJson({'message': error.message.toString()});
    }

    return ErrorApi.fromJson(json.decode(error.response.toString()));
  }
}

class RespApi {
  int? code;
  int? timestamp;
  String? message;
  dynamic data;
  bool? success;

  RespApi({
    this.code,
    this.timestamp,
    this.message,
    this.data,
    this.success,
  });

  RespApi.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['timestamp'] = timestamp;
    data['message'] = message;
    data['data'] = this.data;
    data['success'] = success;
    return data;
  }
}

class ErrorApi {
  int? status;
  String? error;
  String? message;

  ErrorApi({this.status, this.error, this.message});

  ErrorApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
