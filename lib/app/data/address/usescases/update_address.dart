import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/entities/address_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/remotedatasource/address_remote_datasource.dart';
class UpdateAddress {
  final AddressRemoteDataSource repository = AddressRemoteDataSource();

  Future<Either<Failure, bool>> call(int id, AddressEntities address) {
    return repository.updateAddress(id, address);
  }
}
