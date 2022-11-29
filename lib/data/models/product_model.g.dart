// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      address: json['address'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      productName: json['pruduct_name'] as String? ?? '',
      salary: (json['salary'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'image_url': instance.imageUrl,
      'address': instance.address,
      'salary': instance.salary,
      'product_id': instance.productId,
      'pruduct_name': instance.productName,
    };
