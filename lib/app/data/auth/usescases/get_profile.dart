import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/model/profile_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/service/auth_service.dart';

class GetProfile {
  final AuthService _repository = AuthService();

  Future<Either<Failure, ProfileEntities>> call() {
    return _repository.profile();
  }
}
