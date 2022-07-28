// To parse this JSON data, do
//
//     final areaModel = areaModelFromJson(jsonString);

import 'dart:convert';

import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

List<AreaModel> areaModelFromJson(String str) =>
    List<AreaModel>.from(json.decode(str).map((x) => AreaModel.fromJson(x)));

String areaModelToJson(List<AreaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaModel {
  AreaModel({
    required this.id,
    required this.name,
    required this.assignedTo,
    required this.assignedBy,
    required this.location,
    required this.status,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  UserModelMini assignedTo;
  UserModelMini assignedBy;
  Location location;
  int status;
  bool enabled;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AreaModel copyWith({
    required String id,
    required String name,
    required UserModelMini assignedTo,
    required UserModelMini assignedBy,
    required Location location,
    required int status,
    required bool enabled,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int v,
  }) =>
      AreaModel(
        id: id,
        name: name,
        assignedTo: assignedTo,
        assignedBy: assignedBy,
        location: location,
        status: status,
        enabled: enabled,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
      );

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json["_id"],
        name: json["name"],
        assignedTo: UserModelMini.fromJson(json["assignedTo"]),
        assignedBy: UserModelMini.fromJson(json["assignedBy"]),
        location: Location.fromJson(json["location"]),
        status: json["status"],
        enabled: json["enabled"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "name": name,
        "assignedTo": assignedTo.id,
        "assignedBy": assignedBy.id,
        "location": location.toJson(),
        "status": status,
        "enabled": enabled,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };

  static AreaModel empty() {
    return AreaModel(
        id: '',
        name: '',
        assignedTo: UserModelMini.empty(),
        assignedBy: UserModelMini.empty(),
        location: Location.empty(),
        status: 0,
        enabled: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0);
  }
}
