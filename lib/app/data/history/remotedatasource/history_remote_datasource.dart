import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/entities/history_entities.dart';

class HistoryRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, List<HistoryEntities>>> getHistory() async {
    try {
      final response = await apiHelper.get('/history');
      final data = response.data['data'] as List;
      final result = data.map((e) => HistoryEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}