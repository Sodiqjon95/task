// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserItem _$UserItemFromJson(Map<String, dynamic> json) => UserItem(
      userId: json['user_id'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      userAuth: json['user_auth'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
    );

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'user_auth': instance.userAuth,
      'user_id': instance.userId,
      'user_name': instance.userName,
    };
