// To parse this JSON data, do
//
//     final fileDetailMini = fileDetailMiniFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

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
      required this.isUseable
      // required this.area
      });

  final String id;
  final String filename, path;
  final Location location;
  bool isUseable;
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
          isUseable: isUseable
          // area: area
          );

  factory FileDetailMini.fromJson(Map<String, dynamic> json) => FileDetailMini(
      id: json["_id"],
      filename: json["filename"],
      location: Location.fromJson(json["location"]),
      isUseable: json["useable"],
      path: json["path"]
      // area: Area.fromJson(json["area"])
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "filename": filename,
        "path": path,
        "useable": isUseable,
        "location": location.toJson(),
      };
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
}
