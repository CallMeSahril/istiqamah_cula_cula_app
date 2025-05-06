import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/favorite/remote_datasource/favorites_remote_datasource.dart';

class PostFavorite {
  final FavoritesRemoteDataSource repository = FavoritesRemoteDataSource();
  Future<Either<Failure, bool>> call(int productId) =>
      repository.addFavorite(productId);
}
