
import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

class FavoritesRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<ProductEntities>>> getFavorites() async {
    try {
      final response = await apiHelper.get('/favorites');
      final data = response.data['data'] as List;
      final result = data.map((e) => ProductEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> addFavorite(int productId) async {
    try {
      final response = await apiHelper.post('/favorites', data: {
        'product_id': productId,
      });
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
