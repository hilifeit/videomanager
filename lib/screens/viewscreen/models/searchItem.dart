// To parse this JSON data, do
//
//     final searchItem = searchItemFromJson(jsonString);

import 'dart:convert';

SearchItem searchItemFromJson(String str) =>
    SearchItem.fromJson(json.decode(str));

String searchItemToJson(SearchItem data) => json.encode(data.toJson());

class SearchItem {
  SearchItem({
    required this.count,
    required this.results,
  });

  final int count;
  final List<Result> results;

  SearchItem copyWith({
    required int count,
    required List<Result> results,
  }) =>
      SearchItem(
        count: count,
        results: results,
      );

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.filename,
    required this.path,
    required this.startCoordinate,
    required this.area,
    required this.endCoordinate,
    required this.score,
  });

  final String id;
  final String filename;
  final String path;
  final Coordinate startCoordinate;
  final Area area;
  final Coordinate endCoordinate;
  final double score;

  Result copyWith({
    required String id,
    required String filename,
    required String path,
    required Coordinate startCoordinate,
    required Area area,
    required Coordinate endCoordinate,
    required double score,
  }) =>
      Result(
        id: id,
        filename: filename,
        path: path,
        startCoordinate: startCoordinate,
        area: area,
        endCoordinate: endCoordinate,
        score: score,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        filename: json["filename"],
        path: json["path"],
        startCoordinate: Coordinate.fromJson(json["startCoordinate"]),
        area: Area.fromJson(json["area"]),
        endCoordinate: Coordinate.fromJson(json["endCoordinate"]),
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "filename": filename,
        "path": path,
        "startCoordinate": startCoordinate.toJson(),
        "area": area.toJson(),
        "endCoordinate": endCoordinate.toJson(),
        "score": score,
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

class Coordinate {
  Coordinate({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  Coordinate copyWith({
    required double lat,
    required double lng,
  }) =>
      Coordinate(
        lat: lat,
        lng: lng,
      );

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
