// product_id
// ""
// text
// ""
// (string)
// user_id
// ""

import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {

  @JsonKey(defaultValue: "", name: "product_id")
  String productId;

  @JsonKey(defaultValue: "", name: "text")
  String text;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  @JsonKey(defaultValue: "", name: "user_name")
  String userName;

  @JsonKey(defaultValue: "", name: "comment_id")
  String commentId;

  CommentModel({
    required this.userId,
    required this.text,
    required this.productId,
    required this.commentId,
    required this.userName
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}