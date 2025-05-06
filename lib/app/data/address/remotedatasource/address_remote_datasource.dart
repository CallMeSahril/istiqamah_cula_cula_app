import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/entities/address_entities.dart';

class AddressRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<AddressEntities>>> getAddresses() async {
    try {
      final response = await apiHelper.get('/addresses');
      final data = response.data['data'] as List;
      final result = data.map((e) => AddressEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> addAddress(AddressEntities address) async {
    try {
      await apiHelper.post('/addresses', data: address.toJson());
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> updateAddress(
      int id, AddressEntities address) async {
    try {
      await apiHelper.post('/addresses/$id',
          data: address.toJson()); // pakai post seperti yang kamu minta
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteAddress(int id) async {
    try {
      await apiHelper
          .post('/addresses/$id/delete', data: {}); // custom post-delete
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
