import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/chat/controller/chat_controller.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? timer;

@override
void initState() {
  super.initState();
  controller.fetchChats(); // initial fetch
  timer = Timer.periodic(Duration(seconds: 5), (timer) {
    controller.fetchChats();
  });
}

@override
void dispose() {
  timer?.cancel();
  textController.dispose();
  scrollController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Color(0xffFF2B2A),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final chats = controller.chats;

              if (chats.isEmpty) {
                return Center(child: Text("Belum ada pesan."));
              }

              return ListView.builder(
                controller: scrollController,
                reverse: true,
                padding: EdgeInsets.all(12),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[chats.length - 1 - index];
                  final isMe = chat.type == "chat"; 
                    final adjustedTime = chat.createdAt?.add(Duration(hours: 7)) ?? DateTime.now();
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.red[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.pesan ?? "",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat("HH:mm").format(adjustedTime),
                            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xffFF2B2A)),
                  onPressed: () {
                    final text = textController.text.trim();
                    if (text.isNotEmpty) {
                      controller.sendMessage(text);
                      textController.clear();
                      Future.delayed(Duration(milliseconds: 200), () {
                        scrollController.jumpTo(0.0);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
