import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/remote_datasource.dart/cart_remote_data_source.dart';

class DeleteCart {
  final CartRemoteDatasource repository = CartRemoteDatasource();

  Future<Either<Failure, bool>> call(int cartId) {
    return repository.deleteCart(cartId);
  }
}
