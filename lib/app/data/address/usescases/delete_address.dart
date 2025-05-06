import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/remotedatasource/address_remote_datasource.dart';

class DeleteAddress {
  final AddressRemoteDataSource repository = AddressRemoteDataSource();

  Future<Either<Failure, bool>> call(int id) {
    return repository.deleteAddress(id);
  }
}
