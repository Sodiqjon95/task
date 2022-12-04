// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsModel _$DetailsModelFromJson(Map<String, dynamic> json) => DetailsModel(
      amount: json['amount'] as String? ?? '',
      reciever: json['reciever'] as String? ?? '',
      reciever_card_number: json['reciever_card_number'] as String? ?? '',
      sender: json['sender'] as String? ?? '',
    );

Map<String, dynamic> _$DetailsModelToJson(DetailsModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'reciever': instance.reciever,
      'reciever_card_number': instance.reciever_card_number,
      'sender': instance.sender,
    };
