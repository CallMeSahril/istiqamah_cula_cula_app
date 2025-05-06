import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/service/auth_service.dart';

class PostLogin {
  final AuthService repositories = AuthService();
  Future<Either<Failure, bool>> call({required String email, password}) {
    return repositories.login(email: email, password: password);
  }
}
