import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/config/token.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/network_checker.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/model/profile_model.dart';

class AuthService {
  ApiHelper _apiHelper = ApiHelper();

  Future<Either<Failure, bool>> login(
      {required String email, required String password}) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.post(
        '/login',
        data: {"email": email, "password": password},
      );

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final result = response.data['meta']['code'] == 200;
      final refreshToken =
          "${response.data['data']['token_type']} ${response.data['data']['access_token']}";
      final authStorage = await AuthStorage.getInstance();
      await authStorage.saveToken(refreshToken);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ProfileEntities>> profile() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.get(
        '/me',
      );

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final data = response.data['data'];
      final result = ProfileEntities.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ProfileEntities>> register(
      {required String name, email, password, phone}) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.post('/register', data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone
      });

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final data = response.data['data'];
      final result = ProfileEntities.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
    File? image,
  }) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final formData = FormData();

      formData.fields
        ..add(MapEntry('name', name))
        ..add(MapEntry('email', email))
        ..add(MapEntry('phone', phone));

      if (password != null && password.isNotEmpty) {
        formData.fields.add(MapEntry('password', password));
      }

      if (image != null) {
        final fileName = image.path.split('/').last;
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path, filename: fileName),
        ));
      }

      final response = await _apiHelper.post(
        '/me/update', // sesuaikan endpoint kamu
        data: formData,
      );

      if (response.data == null) {
        return Left(ServerFailure("Tidak ada respon dari server"));
      }

      final meta = response.data['meta'];
      if (meta['code'] == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(meta['message'] ?? "Gagal update profil"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
