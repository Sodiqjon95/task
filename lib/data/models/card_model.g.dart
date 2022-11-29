// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      userId: json['user_id'] as String? ?? '',
      cardId: json['card_id'] as String? ?? '',
      cardNum: json['card_num'] as String? ?? '',
      cardSalary: (json['card_salary'] as num?)?.toDouble() ?? 0.0,
      holderName: json['holder_name'] as String? ?? '',
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'card_id': instance.cardId,
      'card_num': instance.cardNum,
      'card_salary': instance.cardSalary,
      'holder_name': instance.holderName,
      'user_id': instance.userId,
    };
