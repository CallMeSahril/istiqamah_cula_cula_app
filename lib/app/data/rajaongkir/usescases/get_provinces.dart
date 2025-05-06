
import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/province.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/remote_datasource/rajaongkir_remotedatasource.dart';

class GetProvinces {
  final RajaOngkirRemoteDataSource repository = RajaOngkirRemoteDataSource();
  Future<Either<Failure, List<Province>>> call() => repository.getProvinces();
}