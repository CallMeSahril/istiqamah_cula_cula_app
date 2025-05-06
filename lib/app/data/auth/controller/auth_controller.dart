import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/model/profile_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/usescases/get_profile.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/usescases/post_login.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/usescases/post_register.dart';

class AuthController extends GetxController {
  final PostLogin _postLogin = PostLogin();
  final PostRegister _postRegister = PostRegister();
  final GetProfile _getProfile = GetProfile();

  // ✅ Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final result = await _postLogin.call(email: email, password: password);
    return result.fold(
      (failure) {
        final message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi lambat',
          _ => failure.message ?? 'Gagal login',
        };
        print("Login Error: $message");
        return false;
      },
      (success) async {
        return true;
      },
    );
  }

  // ✅ Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final result = await _postRegister.call(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );

    return result.fold(
      (failure) {
        final message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi lambat',
          _ => failure.message ?? 'Gagal daftar',
        };
        print("Register Error: $message");
        return false;
      },
      (user) async {
        return true;
      },
    );
  }

  // ✅ Get Profile
  Future<ProfileEntities> getProfile() async {
    final result = await _getProfile.call();

    return result.fold(
      (failure) {
        final message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi lambat',
          _ => failure.message ?? 'Gagal ambil profile',
        };
        print("Profile Error: $message");
        return ProfileEntities();
      },
      (profile) async {
        return profile;
      },
    );
  }
}
