import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/entities/notification_entities.dart';

class NotificationRemoteDataSource {
  final ApiHelper apiHelper = ApiHelper();


  Future<Either<Failure, List<NotificationEntities>>> getNotifications() async {
    try {
      final response = await apiHelper.get('/notification');
      final data = response.data['data'] as List;
      final result = data.map((e) => NotificationEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
