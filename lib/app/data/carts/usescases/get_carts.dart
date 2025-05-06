import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/entities/carts_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/remote_datasource.dart/cart_remote_data_source.dart';

class GetCarts {
  final CartRemoteDatasource repository = CartRemoteDatasource();

  Future<Either<Failure, List<CartEntities>>> call() {
    return repository.getCarts();
  }
}
