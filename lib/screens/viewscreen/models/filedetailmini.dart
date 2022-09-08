// To parse this JSON data, do
//
//     final fileDetailMini = fileDetailMiniFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';

List<FileDetailMini> fileDetailMiniFromJson(String str) =>
    List<FileDetailMini>.from(
        json.decode(str).map((x) => FileDetailMini.fromJson(x)));

String fileDetailMiniToJson(List<FileDetailMini> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileDetailMini {
  FileDetailMini(
      {required this.id,
      required this.filename,
      required this.location,
      required this.path,
      required this.isUseable,
      required this.status,
      this.foundPath = '',
      this.isSelected = false,
      this.assignDetail,
      this.pair,
      required this.isLeft
      // required this.area
      });

  final String id;
  final String? pair;
  final String filename, path;
  String foundPath;
  final Location location;
  final Status status;
  final List<OriginalLocation> originalLocation = [];
  final bool isLeft;
  bool isUseable;
  bool isSelected;
  final AssignDetail? assignDetail;
  // final Area area;
  Rect? boundingBox;

  FileDetailMini copyWith({
    required String id,
    required String filename,
    required Location location,
    required Area area,
  }) =>
      FileDetailMini(
          id: id,
          filename: filename,
          location: location,
          path: path,
          isUseable: isUseable,
          status: status,
          assignDetail: assignDetail,
          isLeft: isLeft
          // area: area
          );

  factory FileDetailMini.fromJson(Map<String, dynamic> json) => FileDetailMini(
      id: json["_id"],
      filename: json["filename"],
      location: Location.fromJson(json["location"]),
      isUseable: json["useable"],
      path: json["path"],
      isLeft: json["isLeft"] ?? false,
      assignDetail: json["assignDetail"] != null
          ? AssignDetail.fromJson(json["assignDetail"])
          : null,
      pair: json["pair"],
      status: Status.fromJson(json["status"] ?? jsonDecode('{"status":0}'))
      // area: Area.fromJson(json["area"])
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "filename": filename,
        "path": path,
        "useable": isUseable,
        "location": location.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FileDetailMini &&
        other.id == id &&
        other.path == path &&
        other.filename == filename &&
        other.isUseable == isUseable &&
        other.assignDetail == assignDetail &&
        other.location == location &&
        other.status == status;
  }

  @override
  int get hashCode => super.hashCode;
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<List<double>> coordinates;

  Location copyWith({
    required String type,
    required List<List<double>> coordinates,
  }) =>
      Location(
        type: type,
        coordinates: coordinates,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
  static Location empty() => Location(type: 'LineString', coordinates: []);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Location &&
        other.type == type &&
        other.coordinates == coordinates;
  }

  @override
  int get hashCode => super.hashCode;
}

class Area {
  Area({
    required this.state,
    required this.city,
    required this.area,
  });

  final int state;
  final String city, area;

  Area copyWith({
    required String type,
    required List<List<double>> coordinates,
  }) =>
      Area(state: state, city: city, area: area);

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        area: json["area"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "city": city,
        "state": state,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Area &&
        other.area == area &&
        other.city == city &&
        other.state == state;
  }

  @override
  int get hashCode => super.hashCode;
}

class Status {
  Status({
    required this.status,
  });

  final int status;

  Status copyWith({required int status}) => Status(
        status: status,
      );

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class AssignDetail {
  AssignDetail({
    this.area,
    this.assignedTo,
  });

  String? area;
  String? assignedTo;

  AssignDetail copyWith({
    String? area,
    String? assignedTo,
  }) =>
      AssignDetail(
        area: area ?? this.area,
        assignedTo: assignedTo ?? this.assignedTo,
      );

  factory AssignDetail.fromRawJson(String str) =>
      AssignDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignDetail.fromJson(Map<String, dynamic> json) => AssignDetail(
        area: json["area"],
        assignedTo: json["assignedTo"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "assignedTo": assignedTo,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AssignDetail &&
        other.area == area &&
        other.assignedTo == assignedTo;
  }

  @override
  int get hashCode => super.hashCode;
}

class FileWithDistance {
  FileWithDistance({required this.file, required this.distance});
  final FileDetailMini file;
  final double distance;
}
