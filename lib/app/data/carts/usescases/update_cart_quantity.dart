import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/remote_datasource.dart/cart_remote_data_source.dart';

class UpdateCartQuantity {
  final CartRemoteDatasource repository = CartRemoteDatasource();

  Future<Either<Failure, bool>> call({required int cartId, required int quantity}) {
    return repository.updateCartQuantity(cartId: cartId, quantity: quantity);
  }
}
