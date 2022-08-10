// To parse this JSON data, do
//
//     final userModelMini = userModelMiniFromJson(jsonString);

import 'dart:convert';

List<UserModelMini> userModelMiniListFromJson(String str) =>
    List<UserModelMini>.from(
        json.decode(str).map((x) => UserModelMini.fromJson(x)));

UserModelMini userModelMiniFromJson(String str) =>
    UserModelMini.fromJson(json.decode(str));

String userModelMiniToJson(UserModelMini data) => json.encode(data.toJson());

class UserModelMini {
  UserModelMini(
      {required this.id,
      required this.name,
      required this.role,
      required this.createdAt,
      this.lastActive,
      this.superVisor,
      this.accessToken,
      this.refreshToken,
      this.isActive = false});

  String id;
  String name;
  int role;
  DateTime createdAt;
  DateTime? lastActive;
  SuperVisor? superVisor;
  String? accessToken;
  String? refreshToken;
  bool isActive;

  UserModelMini copyWith({
    required String id,
    required String name,
    required int role,
    required DateTime createdAt,
    SuperVisor? superVisor,
    String? accessToken,
    String? refreshToken,
  }) =>
      UserModelMini(
        id: id,
        name: name,
        role: role,
        createdAt: createdAt,
        superVisor: superVisor,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  factory UserModelMini.fromJson(Map<String, dynamic> json) {
    return UserModelMini(
      id: json["_id"],
      name: json["name"],
      role: json["role"],
      createdAt: DateTime.parse(json["createdAt"]),
      superVisor: json["superVisor"] == null
          ? null
          : SuperVisor.fromJson(json["superVisor"]),
      accessToken: json["accessToken"],
      lastActive: json["lastActive"] != null
          ? DateTime.parse(json["lastActive"])
          : null,
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "superVisor": superVisor != null ? superVisor!.toJson() : null,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
  static UserModelMini empty() =>
      UserModelMini(id: '', name: '', role: 0, createdAt: DateTime.now());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is UserModelMini &&
        other.id == id &&
        other.name == name &&
        other.role == role &&
        other.superVisor == superVisor &&
        other.createdAt == createdAt &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => super.hashCode;
}

class SuperVisor {
  SuperVisor({
    this.id,
    this.name = '',
    this.role,
  });

  String? id;
  String name;
  int? role;

  SuperVisor copyWith({
    required String id,
    String name = '',
    int? role,
  }) =>
      SuperVisor(
        id: id,
        name: name,
        role: role!,
      );

  factory SuperVisor.fromJson(Map<String, dynamic> json) => SuperVisor(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SuperVisor &&
        other.id == id &&
        other.name == name &&
        other.role == role;
  }

  @override
  int get hashCode => super.hashCode;
}
