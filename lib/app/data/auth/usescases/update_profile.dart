import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/service/auth_service.dart';

class UpdateProfile {
  final AuthService _service = AuthService();

  Future<Either<Failure, bool>> call({
    required String name,
    required String email,
    required String phone,
    String? password,
    File? image,
  }) async {
    return await _service.updateProfile(
      name: name,
      email: email,
      phone: phone,
      password: password,
      image: image,
    );
  }
}
