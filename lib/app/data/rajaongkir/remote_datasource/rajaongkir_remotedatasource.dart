import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/city.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/courier.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/ongkir_service.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/province.dart';

class RajaOngkirRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<Province>>> getProvinces() async {
    try {
      final res = await apiHelper.get('/provinces');
      final data = res.data['data'] as List;
      final result = data.map((e) => Province.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<City>>> getCities(int provinceId) async {
    try {
      final res = await apiHelper.get('/cities/$provinceId');
      final data = res.data['data'] as List;
      final result = data.map((e) => City.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Courier>>> getCouriers() async {
    try {
      final res = await apiHelper.get('/available-couriers');
      final data = res.data['data'] as Map<String, dynamic>;
      final result =
          data.entries.map((e) => Courier(code: e.key, name: e.value)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<OngkirService>>> checkOngkir({
    required int origin,
    required int destination,
    required int weight,
    required String courier,
  }) async {
    try {
      final res = await apiHelper.post('/check-shipping-cost', data: {
        'origin': origin,
        'destination': destination,
        'weight': weight,
        'courier': courier
      });
      final data = res.data['data'][0]['costs'] as List;
      final result = data.map((e) => OngkirService.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
