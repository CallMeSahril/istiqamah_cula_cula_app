import 'package:dartz/dartz.dart';
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
  // Future<Either<Failure, List<OrderStatusEntities>>> getPendingOrder(
  //     {required OrderStatus status}) async {
  //   final isConnected = await NetworkChecker.isConnected();
  //   if (!isConnected) return Left(NoConnectionFailure());

  //   final isSlow = await NetworkChecker.isConnectionSlow();
  //   if (isSlow) return Left(SlowConnectionFailure());
  //   String statusValue = '';
  //   switch (status) {
  //     case OrderStatus.pending:
  //       statusValue = 'pending';

  //       break;
  //     case OrderStatus.packing:
  //       statusValue = 'packing';

  //       break;
  //     case OrderStatus.delivering:
  //       statusValue = 'delivering';

  //       break;
  //     default:
  //       statusValue = 'pending';
  //   }
  //   try {
  //     final response = await apiHelper.get(
  //       '/orders/$statusValue',
  //     );

  //     if (response.data == null || response.data['data'] == null) {
  //       return Left(ServerFailure("Data tidak ditemukan"));
  //     }

  //     final data = response.data['data'] as List;
  //     final result =
  //         data.map((item) => OrderStatusEntities.fromJson(item)).toList();
  //     return Right(result);
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

  // Future<Either<Failure, List<HistoryEntities>>> getHistory() async {
  //   final isConnected = await NetworkChecker.isConnected();
  //   if (!isConnected) return Left(NoConnectionFailure());

  //   final isSlow = await NetworkChecker.isConnectionSlow();
  //   if (isSlow) return Left(SlowConnectionFailure());

  //   try {
  //     final response = await apiHelper.get(
  //       '/history',
  //     );

  //     if (response.data == null || response.data['data'] == null) {
  //       return Left(ServerFailure("Data tidak ditemukan"));
  //     }

  //     final data = response.data['data'] as List;
  //     final result =
  //         data.map((item) => HistoryEntities.fromJson(item)).toList();
  //     return Right(result);
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
