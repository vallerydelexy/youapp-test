// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

// import '../../models/auth_model.dart';
// import '../../models/cert_model.dart';
// import '../../models/user_model.dart';
// import 'base_api.dart';

// class AuthApi extends BaseApi {
//   Future<Either<ErrorApi, RespApi>> login(Map<String, dynamic> payload) async {
//     try {
//       final resp = await dio.post('/auth/user', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = AuthModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       // print("Error: ${error.}");
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> refreshToken() async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';
//     try {
//       final resp = await dio.post('/auth/user/refresh');
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = AuthModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       // print("Error: ${error.}");
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> rekey(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/rekey', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> changeAccount(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/auth/user/changeaccount', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = AuthModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getCert(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/certdetail', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = CertModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getQuota(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/getquota', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getAvatar(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/getavatar', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getNotif(Map<String, dynamic> payload, {int page = 0, int size = 20}) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/getNotif/$page/$size', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getCountUnreadNotif() async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.get('/core/user/countunread');
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> unreadNotif(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/readNotif', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> unreadAllNotif(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/readNotif/all', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> getUser(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/getdetail', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = UserModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> changePassword(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/changepassword', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> changePhone(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/changephone', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> updateAvatar(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/core/user/updateavatar', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> updateToken(Map<String, dynamic> payload) async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/auth/firebase/updatetoken', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> forgotPassword(Map<String, dynamic> payload) async {
//     try {
//       final resp = await dio.post('/auth/forgotpassword', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> forgotPasswordVerify(Map<String, dynamic> payload) async {
//     try {
//       final resp = await dio.post('/auth/forgotpassword/verifytoken', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> forgotPasswordChange(Map<String, dynamic> payload) async {
//     try {
//       final resp = await dio.post('/auth/forgotpassword/changepassword', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> regisTotp(Map<String, dynamic> payload) async {
//     try {
//       final resp = await dio.post('/auth/totp/register', data: json.encode(payload));
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> refresh() async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.post('/auth/user/refresh');
//       final data = RespApi.fromJson(resp.data);
//       if (data.data != null) data.data = AuthModel.fromJson(data.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }

//   Future<Either<ErrorApi, RespApi>> userGetRole() async {
//     dio.options.headers['Authorization'] = 'Bearer ${authToken()}';

//     try {
//       final resp = await dio.get('/core/user/getrole');
//       final data = RespApi.fromJson(resp.data);

//       return Right(data);
//     } on DioException catch (error) {
//       return Left(errorHandler(error));
//     }
//   }
// }
