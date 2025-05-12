import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/network_checker.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/model/banner_model.dart';

class BannerService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<Failure, List<BannerEntities>>> getBanners() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.get('/banner');

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final List<BannerEntities> list =
          List<BannerEntities>.from(response.data['data']
              .map((x) => BannerEntities.fromJson(x)));

      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BannerEntities>>> getIklan() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.get('/iklan');

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final List<BannerEntities> list =
          List<BannerEntities>.from(response.data['data']
              .map((x) => BannerEntities.fromJson(x)));

      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
