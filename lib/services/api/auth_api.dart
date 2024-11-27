import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/auth_model.dart';
import 'base_api.dart';

class AuthApi extends BaseApi {
  Future<Either<ErrorApi, RespApi>> login(Map<String, dynamic> payload) async {
    try {
      final resp = await dio.post('/api/login', data: json.encode(payload));
      final data = RespApi.fromJson(resp.data);
      if (data.data != null) data.data = AuthModel.fromJson(data.data);

      return Right(data);
    } on DioException catch (error) {
      return Left(errorHandler(error));
    }
  }

}
