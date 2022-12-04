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

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(defaultValue: "", name: "image_url")
  String imageUrl;

  @JsonKey(defaultValue: "", name: "address")
  String address;

  @JsonKey(defaultValue: 0.0, name: "salary")
  double salary;

  @JsonKey(defaultValue: "", name: "product_id")
  String productId;

  @JsonKey(defaultValue: "", name: "pruduct_name")
  String productName;


  ProductModel({
    required this.description,
    required this.imageUrl,
    required this.address,
    required this.productId,
    required this.productName,
    required this.salary
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}