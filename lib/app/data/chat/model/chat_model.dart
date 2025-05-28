import 'dart:convert';

class ChatModel {
  final Meta? meta;
  final List<ChatEntities>? data;

  ChatModel({this.meta, this.data});

  factory ChatModel.fromRawJson(String str) =>
      ChatModel.fromJson(json.decode(str));

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<ChatEntities>.from(
                json["data"].map((x) => ChatEntities.fromJson(x))),
      );
}

class ChatEntities {
  final int? id;
  final int? userId;
  final String? pesan;
  final String? type;
  final DateTime? createdAt;
  final UserChat? user;

  ChatEntities({
    this.id,
    this.userId,
    this.pesan,
    this.type,
    this.createdAt,
    this.user,
  });

  factory ChatEntities.fromJson(Map<String, dynamic> json) => ChatEntities(
        id: json["id"],
        userId: int.tryParse(json["user_id"].toString()),
        pesan: json["pesan"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"] == null ? null : UserChat.fromJson(json["user"]),
      );
}

class UserChat {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? image;

  UserChat({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.image,
  });

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        image: json["image"],
      );
}

class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({this.code, this.status, this.message});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );
}
