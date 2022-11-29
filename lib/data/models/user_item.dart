import 'package:json_annotation/json_annotation.dart';
part 'user_item.g.dart';

@JsonSerializable()
class UserItem {

  @JsonKey(defaultValue: "", name: "phone_number")
  String phoneNumber;

  @JsonKey(defaultValue: "", name: "user_auth")
  String userAuth;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  @JsonKey(defaultValue: "", name: "user_name")
  String userName;

  UserItem({
    required this.userId,
    required this.phoneNumber,
    required this.userAuth,
    required this.userName
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserItemToJson(this);
}