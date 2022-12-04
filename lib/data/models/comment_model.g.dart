// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userId: json['user_id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      commentId: json['comment_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'text': instance.text,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'comment_id': instance.commentId,
    };
