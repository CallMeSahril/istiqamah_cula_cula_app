import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/remotedatasource/product_remote_datasource.dart';

class GetAllProducts {
  final ProductRemoteDatasource repo = ProductRemoteDatasource();
  Future<Either<Failure, List<ProductEntities>>> call() => repo.getAllProducts();
}
