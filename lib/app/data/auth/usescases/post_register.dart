import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/model/profile_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/service/auth_service.dart';

class PostRegister {
  final AuthService _repository = AuthService();

  Future<Either<Failure, ProfileEntities>> call({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    return _repository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
