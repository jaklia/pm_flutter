import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//@JsonSerializable()
enum Role {
  Admin,
  User,
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int userId;
  @JsonKey(name: "userName")
  String name;
  String email;
  Role role;

  User({@required this.name, this.role, this.email, this.userId});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserList {
  List<User> users;

  UserList(this.users);

  factory UserList.fromJson(Map<String, dynamic> json) => _$UserListFromJson(json);
  Map<String, dynamic> toJson() => _$UserListToJson(this);
}
