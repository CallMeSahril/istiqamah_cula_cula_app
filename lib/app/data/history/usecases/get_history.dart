import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/entities/history_entities.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/remotedatasource/history_remote_datasource.dart';

class GetHistory {
  final HistoryRemoteDataSource dataSource = HistoryRemoteDataSource();

  Future<Either<Failure, List<HistoryEntities>>> call() {
    return dataSource.getHistory();
  }
}