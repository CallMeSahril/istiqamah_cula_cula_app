import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/network_checker.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

class ProductRemoteDatasource {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<Failure, List<ProductEntities>>> getAllProducts() async {
    if (!await NetworkChecker.isConnected()) return Left(NoConnectionFailure());
    if (await NetworkChecker.isConnectionSlow()) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.get('/products');
      final data = response.data['data'] as List;
      final result = data.map((e) => ProductEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ProductEntities>> getProductById(int id) async {
    if (!await NetworkChecker.isConnected()) return Left(NoConnectionFailure());
    if (await NetworkChecker.isConnectionSlow()) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.get('/products/$id');
      final data = response.data['data'];
      return Right(ProductEntities.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductEntities>>> searchProduct(String query) async {
    if (!await NetworkChecker.isConnected()) return Left(NoConnectionFailure());
    if (await NetworkChecker.isConnectionSlow()) return Left(SlowConnectionFailure());

    try {
      final response = await _apiHelper.post('/products/search', data: {
        "search": query,
      });
      final data = response.data['data'] as List;
      final result = data.map((e) => ProductEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
