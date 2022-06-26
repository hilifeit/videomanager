import 'dart:convert';

List<AddNewUser> addNewUserListFromJson(String str) =>
    List<AddNewUser>.from(json.decode(str).map((x) => AddNewUser.fromJson(x)));

AddNewUser addNewUserFromJson(String str) =>
    AddNewUser.fromJson(json.decode(str));

String addNewUserToJson(AddNewUser data) => json.encode(data.toJson());

class AddNewUser {
  AddNewUser(
      {this.userName = '',
      this.role = 0,
      this.name = '',
      this.email = '',
      this.password = '',
      this.mobile = 0,
      this.id = ''});

  String id;
  String userName;
  String name;
  int role;
  String email;
  String password;
  int mobile;

  AddNewUser copyWith({
    required String id,
    required String userName,
    required String name,
    required int role,
    required String email,
    required String password,
    required int mobile,
  }) =>
      AddNewUser(
        id: id,
        userName: userName,
        name: name,
        role: role,
        email: email,
        password: password,
        mobile: mobile,
      );

  factory AddNewUser.fromJson(Map<String, dynamic> json) => AddNewUser(
        id: json["_id"],
        userName: json["username"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        password: json["password"] ?? '',
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": userName,
        "name": name,
        "role": role,
        "email": email,
        "password": password,
        "mobile": mobile,
      };
}
