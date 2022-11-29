// card_id
// "t5cxvG0sLH1cbABXnp2t"
// card_num
// ""
// card_salary
// 500000
// expiry_data
// ""
// holder_name
// ""
// (string)
// user_id
// ""

import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {

  @JsonKey(defaultValue: "", name: "card_id")
  String cardId;

  @JsonKey(defaultValue: "", name: "card_num")
  String cardNum;

  @JsonKey(defaultValue: 0.0, name: "card_salary")
  double cardSalary;

  @JsonKey(defaultValue: "", name: "holder_name")
  String holderName;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;
  CardModel({
    required this.userId,
    required this.cardId,
    required this.cardNum,
    required this.cardSalary,
    required this.holderName
  });
  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}