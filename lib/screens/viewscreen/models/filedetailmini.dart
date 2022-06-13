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
  FileDetailMini({
    required this.id,
    required this.filename,
    required this.location,
  });

  final String id;
  final String filename;
  final Location location;
  Rect? boundingBox;

  FileDetailMini copyWith({
    required String id,
    required String filename,
    required Location location,
  }) =>
      FileDetailMini(
        id: id,
        filename: filename,
        location: location,
      );

  factory FileDetailMini.fromJson(Map<String, dynamic> json) => FileDetailMini(
        id: json["_id"],
        filename: json["filename"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "filename": filename,
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
