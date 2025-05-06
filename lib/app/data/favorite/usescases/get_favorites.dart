import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/favorite/remote_datasource/favorites_remote_datasource.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

class GetFavorites {
  final FavoritesRemoteDataSource repository = FavoritesRemoteDataSource();
  Future<Either<Failure, List<ProductEntities>>> call() =>
      repository.getFavorites();
}
