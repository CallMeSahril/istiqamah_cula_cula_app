import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/model/chat_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/usecases/get_chat.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/usecases/post_chat.dart';

class ChatController extends GetxController {
  final GetChat _getChat = GetChat();
  final PostChat _postChat = PostChat();

  var chats = <ChatEntities>[].obs;

  Future<void> fetchChats() async {
    final result = await _getChat.call();
    result.fold(
      (failure) => print("Get Chat Error: ${failure.message}"),
      (data) => chats.value = data,
    );
  }

  Future<void> sendMessage(String message) async {
    final result = await _postChat.call(message);
    result.fold(
      (failure) => Get.snackbar("Error", failure.message ?? "Gagal mengirim"),
      (success) async {
        await fetchChats(); // refresh chat setelah kirim
      },
    );
  }
}
