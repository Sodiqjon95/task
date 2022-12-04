import 'package:json_annotation/json_annotation.dart';
import 'package:task/data/models/details_model.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {

  @JsonKey(defaultValue: false, name: "status")
  bool status;

  @JsonKey(name: "details")
  DetailsModel details;

  @JsonKey(defaultValue:"", name: "message")
  String message;

  PaymentModel({
    required this.status,
    required this.details,
    required this.message
  });
  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}