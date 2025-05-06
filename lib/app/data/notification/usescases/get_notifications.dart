import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/entities/notification_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/remotedatasource/notification_remotedatasource.dart';

class GetNotifications {
  final NotificationRemoteDataSource dataSource;
  GetNotifications(this.dataSource);

  Future<Either<Failure, List<NotificationEntities>>> call() async {
    return await dataSource.getNotifications();
  }
}
