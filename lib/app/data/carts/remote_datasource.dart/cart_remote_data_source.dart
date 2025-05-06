import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/entities/carts_entities.dart';

class CartRemoteDatasource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<CartEntities>>> getCarts() async {
    try {
      final response = await apiHelper.get('/carts');
      final data = response.data['data'] as List;
      final result = data.map((e) => CartEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> addCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await apiHelper.post('/carts', data: {
        "product_id": productId,
        "quantity": quantity,
      });
      final code = response.data['meta']['code'];
      return Right(code == 200);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> updateCartQuantity({
    required int cartId,
    required int quantity,
  }) async {
    try {
      final response =
          await apiHelper.post('/carts/$cartId/update', data: {
        "quantity": quantity,
      });
      final code = response.data['meta']['code'];
      return Right(code == 200);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteCart(int cartId) async {
    try {
      final response = await apiHelper.post('/carts/$cartId/destroy', data: {});
      final code = response.data['meta']['code'];
      return Right(code == 200);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
