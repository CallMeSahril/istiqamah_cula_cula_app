import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/city.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/remote_datasource/rajaongkir_remotedatasource.dart';

class GetCities {
  final RajaOngkirRemoteDataSource repository = RajaOngkirRemoteDataSource();
  Future<Either<Failure, List<City>>> call(int provinceId) =>
      repository.getCities(provinceId);
}
