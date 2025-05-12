import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/network_checker.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/model/chat_model.dart';

class ChatService {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<Failure, List<ChatEntities>>> getChats() async {
    if (!await NetworkChecker.isConnected()) {
      return Left(NoConnectionFailure());
    }

    try {
      final response = await _apiHelper.get('/chat');

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final data = List<ChatEntities>.from(
        response.data['data'].map((x) => ChatEntities.fromJson(x)),
      );

      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> sendChat(String pesan) async {
    if (!await NetworkChecker.isConnected()) {
      return Left(NoConnectionFailure());
    }

    try {
      final response = await _apiHelper.post('/chat', data: {"pesan": pesan});

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Gagal mengirim pesan"));
      }

      return Right(response.data['data']);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
