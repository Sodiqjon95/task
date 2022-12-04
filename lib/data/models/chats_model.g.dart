// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsModel _$ChatsModelFromJson(Map<String, dynamic> json) => ChatsModel(
      text: json['text'] as String? ?? '',
      createAt: json['creat_at'] as String? ?? '',
      chatId: json['chat_id'] as String? ?? '',
      receiverId: json['receiver_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
    );

Map<String, dynamic> _$ChatsModelToJson(ChatsModel instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'creat_at': instance.createAt,
      'text': instance.text,
      'receiver_id': instance.receiverId,
      'sender_id': instance.senderId,
    };
