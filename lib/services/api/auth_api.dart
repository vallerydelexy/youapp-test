import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:test/utils/preferences.dart';

import '../../models/auth_model.dart';
import 'base_api.dart';

class AuthApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> login(Map<String, dynamic> payload) async {
    try {
      final resp = await dio.post('/api/login', data: json.encode(payload));
      final data = RespApi.fromResponse(resp);
      debugPrint('AuthApi - login: ${data.message}');
      if (data.token != null && data.token!.isNotEmpty) {
        await Preferences.setAccessToken(data.token!);
        debugPrint('Access token saved successfully');
      }
      return Right(data);
    } on DioException catch (error) {
      return Left(errorHandler(error)); 
    }
  }

  Future<Either<ErrorApi, RespApi>> register(Map<String, dynamic> payload) async {
    try {
      final resp = await dio.post('/api/register', data: json.encode(payload));
      final data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = AuthModel.fromJson(data.data);

      return Right(data);
    } on DioException catch (error) {
      return Left(errorHandler(error));
    }
  }

}
