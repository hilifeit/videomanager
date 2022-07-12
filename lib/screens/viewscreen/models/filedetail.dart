// To parse this JSON data, do
//
//     final fileDetail = fileDetailFromJson(jsonString);

import 'dart:convert';

import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

FileDetail fileDetailFromJson(String str) =>
    FileDetail.fromJson(json.decode(str));

String fileDetailToJson(FileDetail data) => json.encode(data.toJson());

class FileDetail {
  FileDetail({
    required this.id,
    required this.path,
    required this.useable,
    required this.info,
    required this.area,
    required this.location,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String path;
  final bool useable;
  final Info info;
  final Area area;
  final Location location;
  final bool enabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  FileDetail copyWith({
    required String id,
    required String path,
    required bool useable,
    required Info info,
    required Area area,
    required Location location,
    required bool enabled,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int v,
  }) =>
      FileDetail(
        id: id,
        path: path,
        useable: useable,
        info: info,
        area: area,
        location: location,
        enabled: enabled,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
      );

  factory FileDetail.fromJson(Map<String, dynamic> json) => FileDetail(
        id: json["_id"],
        path: json["path"],
        useable: json["useable"],
        info: Info.fromJson(json["info"]),
        area: Area.fromJson(json["area"]),
        location: Location.fromJson(json["location"]),
        enabled: json["enabled"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "path": path,
        "useable": useable,
        "info": info.toJson(),
        "area": area.toJson(),
        "location": location.toJson(),
        "enabled": enabled,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Area {
  Area({
    required this.state,
    required this.city,
    required this.area,
    required this.id,
  });

  final int state;
  final String city;
  final String area;
  final String id;

  Area copyWith({
    required int state,
    required String city,
    required String area,
    required String id,
  }) =>
      Area(
        state: state,
        city: city,
        area: area,
        id: id,
      );

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        state: json["state"],
        city: json["city"],
        area: json["area"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "city": city,
        "area": area,
        "_id": id,
      };
}

class Info {
  Info({
    required this.md5,
    required this.rider,
    required this.filename,
    required this.size,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.modifiedDate,
    required this.isLeft,
    required this.hasProcessed,
    required this.id,
  });

  final String md5;
  final String rider;
  final String filename;
  final int size;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime duration;
  final DateTime modifiedDate;
  final bool isLeft;
  final bool hasProcessed;
  final String id;

  Info copyWith({
    required String md5,
    required String rider,
    required String filename,
    required int size,
    required DateTime startTime,
    required DateTime endTime,
    required DateTime duration,
    required DateTime modifiedDate,
    required bool isLeft,
    required bool hasProcessed,
    required String id,
  }) =>
      Info(
        md5: md5,
        rider: rider,
        filename: filename,
        size: size,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
        modifiedDate: modifiedDate,
        isLeft: isLeft,
        hasProcessed: hasProcessed,
        id: id,
      );

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        md5: json["md5"],
        rider: json["rider"],
        filename: json["filename"],
        size: json["size"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        duration: DateTime.parse(json["duration"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isLeft: json["isLeft"],
        hasProcessed: json["hasProcessed"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "md5": md5,
        "rider": rider,
        "filename": filename,
        "size": size,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "duration": duration.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isLeft": isLeft,
        "hasProcessed": hasProcessed,
        "_id": id,
      };
}
