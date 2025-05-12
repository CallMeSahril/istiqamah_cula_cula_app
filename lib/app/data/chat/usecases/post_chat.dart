import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/service/chat_service.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';

class PostChat {
  final ChatService _repository = ChatService();

  Future<Either<Failure, String>> call(String pesan) {
    return _repository.sendChat(pesan);
  }
}
