import 'dart:convert';

import 'package:videomanager/screens/users/model/usermodel.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';

List<AddNewUser> addNewUserListFromJson(String str) =>
    List<AddNewUser>.from(json.decode(str).map((x) => AddNewUser.fromJson(x)));

AddNewUser addNewUserFromJson(String str) =>
    AddNewUser.fromJson(json.decode(str));

String addNewUserToJson(AddNewUser data) => json.encode(data.toJson());

class AddNewUser {
  AddNewUser({
    this.username = '',
    this.role = 0,
    this.name = '',
    this.email = '',
    this.password = '',
    this.mobile = 0,
    this.id = '',
    required this.superVisor,
  });

  String id;
  String username;
  String name;
  int role;
  String email;
  String password;
  int mobile;
  SuperVisor superVisor;

  AddNewUser copyWith({
    required String id,
    required String username,
    required String name,
    required int role,
    required String email,
    required String password,
    required int mobile,
    required SuperVisor superVisor,
  }) =>
      AddNewUser(
        id: id,
        username: username,
        name: name,
        role: role,
        email: email,
        password: password,
        mobile: mobile,
        superVisor: superVisor,
      );

  factory AddNewUser.fromJson(Map<String, dynamic> json) => AddNewUser(
        id: json["_id"],
        username: json["username"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        password: json["password"] ?? '',
        mobile: json["mobile"],
        superVisor: SuperVisor.fromJson(json["superVisor"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "name": name,
        "role": role,
        "email": email,
        "password": password,
        "mobile": mobile,
        "superVisor": superVisor.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AddNewUser &&
        other.id == id &&
        other.username == username &&
        other.name == name &&
        other.role == role &&
        other.email == email &&
        other.password == password &&
        other.mobile == mobile &&
        other.superVisor == superVisor;
  }

  @override
  int get hashCode => super.hashCode;
}
