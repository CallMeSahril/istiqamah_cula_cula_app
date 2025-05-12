import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/model/chat_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/service/chat_service.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';

class GetChat {
  final ChatService _repository = ChatService();

  Future<Either<Failure, List<ChatEntities>>> call() {
    return _repository.getChats();
  }
}
