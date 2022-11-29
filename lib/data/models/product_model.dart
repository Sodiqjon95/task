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
// description
// "Janr/bo‘lim: Romanlar, hikoyalar Muallif: Javlon Jovliev Nashr yili: 2020 Tili: O'zbek (kir) Betlar: 376 Nashriyot: Nihol ISBN raqami: 978-9943-23-177-1 Kitob mahsulotlarining xarakteristikalari, yetkazib berish shartlari, tashqi ko'rinishi va rangi haqidagi ma'lumotlar faqat ma'lumot uchun mo'ljallangan va joylashtirilgan paytda mavjud bo'lgan eng so'nggi ma'lumotlarga asoslanadi."

// image_url
// "https://firebasestorage.googleapis.com/v0/b/phone-firebase-21aad.appspot.com/o/image%2Fs6667.jpg?alt=media&token=9eb7fbcd-363b-4eec-9a08-8d274a7cfc61"
// address
// [41.292657° N, 69.222116° E]
// product_id
// "MZudlBhvJ0tQ4LW4yyqT"
// pruduct_name
// "Qorqma"
// salary
// 20000
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