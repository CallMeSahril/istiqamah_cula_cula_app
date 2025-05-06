import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/remotedatasource/product_category_remote_datasource.dart';

class GetAllCategories {
  final ProductCategoryRemoteDataSource repo =
      ProductCategoryRemoteDataSource();

  Future<Either<Failure, List<ProductCategoryEntities>>> call() {
    return repo.getAllCategories();
  }
}
