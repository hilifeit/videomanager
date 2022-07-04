import 'dart:convert';

import 'package:videomanager/screens/users/model/usermodelmini.dart';

List<UserModel> userModelListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
    required this.email,
    // required this.password,
    required this.mobile,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.accessToken,
    required this.refreshToken,
    this.superVisor,
  });

  String id;
  String username;
  String name;
  int role;
  String email;
  // String password;
  int mobile;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String accessToken, refreshToken;
  SuperVisor? superVisor;

  UserModel copyWith({
    required String id,
    required String username,
    required String name,
    required int role,
    required String email,
    // required String password,
    required int mobile,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int v,
    required String accessToken,
    required String refreshToken,
    SuperVisor? superVisor,
  }) =>
      UserModel(
        id: id,
        username: username,
        name: name,
        role: role,
        email: email,
        // password: password,
        mobile: mobile,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
        accessToken: accessToken,
        refreshToken: refreshToken,
        superVisor: superVisor,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        // password: json["password"] ?? '',
        mobile: json["mobile"],
        superVisor: json["superVisor"] != null
            ? SuperVisor.fromJson(json["superVisor"])
            : null,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        accessToken: json['accessToken'] ?? '',
        refreshToken: json['refreshToken'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "name": name,
        "role": role,
        "email": email,
        // "password": password,
        "mobile": mobile,
        "superVisor": superVisor != null ? superVisor!.toJson() : null,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
