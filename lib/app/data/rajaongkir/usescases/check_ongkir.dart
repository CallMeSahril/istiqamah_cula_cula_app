import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/ongkir_service.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/remote_datasource/rajaongkir_remotedatasource.dart';

class CheckOngkir {
  final RajaOngkirRemoteDataSource repository = RajaOngkirRemoteDataSource();
  Future<Either<Failure, List<OngkirService>>> call({
    required int origin,
    required int destination,
    required int weight,
    required String courier,
  }) => repository.checkOngkir(
        origin: origin,
        destination: destination,
        weight: weight,
        courier: courier,
      );
}
