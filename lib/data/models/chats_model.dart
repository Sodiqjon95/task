import 'package:json_annotation/json_annotation.dart';

part 'chats_model.g.dart';


/*
chat_id

creat_at

reseveir_id

sender_id

text
 */
@JsonSerializable()
class ChatsModel {

  @JsonKey(defaultValue: '', name: "chat_id")
  String chatId;

  @JsonKey(defaultValue: "", name: "creat_at")
  String createAt;

  @JsonKey(defaultValue:"", name: "text")
  String text;

  @JsonKey(defaultValue:"", name: "receiver_id")
  String receiverId;

  @JsonKey(defaultValue:"", name: "sender_id")
  String senderId;

  ChatsModel({
    required this.text,
    required this.createAt,
    required this.chatId,
    required this.receiverId,
    required this.senderId,

  });
  factory ChatsModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsModelToJson(this);
}