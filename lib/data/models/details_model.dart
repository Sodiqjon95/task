import 'package:json_annotation/json_annotation.dart';

part 'details_model.g.dart';

@JsonSerializable()
class DetailsModel {
  @JsonKey(defaultValue: '', name: "amount")
  String amount;

  @JsonKey(defaultValue: "", name: "reciever")
  String reciever;

  @JsonKey(defaultValue: '', name: "reciever_card_number")
  String reciever_card_number;

  @JsonKey(defaultValue: "", name: "sender")
  String sender;

  DetailsModel({
    required this.amount,
    required this.reciever,
    required this.reciever_card_number,
    required this.sender,
  });
  factory DetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsModelToJson(this);
}