import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';

class ProductCategoryRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<ProductCategoryEntities>>> getAllCategories() async {
    try {
      final response = await apiHelper.get('/products-category');
      final data = response.data['data'] as List;
      final result = data.map((e) => ProductCategoryEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ProductCategoryEntities>> getCategoryById(int id) async {
    try {
      final response = await apiHelper.get('/products-category/$id');
      final data = response.data['data'];
      final result = ProductCategoryEntities.fromJson(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
