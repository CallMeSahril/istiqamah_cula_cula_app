import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/model/banner_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/service/banner_service.dart';

class GetBanner {
  final BannerService _repository = BannerService();

  Future<Either<Failure, List<BannerEntities>>> call() {
    return _repository.getBanners();
  }
}
