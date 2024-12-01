import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'base_api.dart';

class UserApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> getProfile() async {
    dio.options.headers['x-access-token'] = await authToken();
    try {
      final resp = await dio.get('/api/getProfile');
      final data = RespApi.fromJson(resp.data);
      debugPrint('UserApi - getProfile: ${data.data}');
      

      return Right(data);
    } on DioException catch (error) {
      // debugPrint('DioException Details: ${error.response?.statusCode}');
      // debugPrint('Response Data: ${error.response?.data}');

      return Left(errorHandler(error));
    } catch (e) {
      // debugPrint('Unexpected error: $e');
      return Left(ErrorApi(message: 'Unexpected error occurred'));
    }
  }

  Future<Either<ErrorApi, RespApi>> updateProfile( Map<String, dynamic> payload) async {
    dio.options.headers['x-access-token'] = await authToken();
    try {
      final resp = await dio.put('/api/updateProfile', data: json.encode(payload));
      final data = RespApi.fromJson(resp.data);
      debugPrint('UserApi - updateProfile: ${data.data}');

      return Right(data);
    } on DioException catch (error) {
      // debugPrint('DioException Details: ${error.response?.statusCode}');
      // debugPrint('Response Data: ${error.response?.data}');

      return Left(errorHandler(error));
    } catch (e) {
      // debugPrint('Unexpected error: $e');
      return Left(ErrorApi(message: 'Unexpected error occurred'));
    }
  }

  Future<Either<ErrorApi, RespApi>> createProfile( Map<String, dynamic> payload) async {
    dio.options.headers['x-access-token'] = await authToken();
    try {
      final resp = await dio.post('/api/createProfile', data: json.encode(payload));
      final data = RespApi.fromJson(resp.data);
      debugPrint('UserApi - createProfile: ${data.data}');

      return Right(data);
    } on DioException catch (error) {
      // debugPrint('DioException Details: ${error.response?.statusCode}');
      // debugPrint('Response Data: ${error.response?.data}');

      return Left(errorHandler(error));
    } catch (e) {
      // debugPrint('Unexpected error: $e');
      return Left(ErrorApi(message: 'Unexpected error occurred'));
    }
  }
}
