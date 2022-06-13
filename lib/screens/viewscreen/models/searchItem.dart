// To parse this JSON data, do
//
//     final searchItem = searchItemFromMap(jsonString);

import 'dart:convert';

SearchItem searchItemFromMap(String str) =>
    SearchItem.fromMap(json.decode(str));

String searchItemToMap(SearchItem data) => json.encode(data.toMap());

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

  factory SearchItem.fromMap(Map<String, dynamic> json) => SearchItem(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.id,
    required this.filename,
    required this.path,
    required this.score,
    required this.startCoordinate,
  });

  final String id;
  final String filename;
  final String path;
  final double score;
  final StartCoordinate startCoordinate;

  Result copyWith({
    required String id,
    required String filename,
    required String path,
    required double score,
    required StartCoordinate startCoordinate,
  }) =>
      Result(
        id: id,
        filename: filename,
        path: path,
        score: score,
        startCoordinate: startCoordinate,
      );

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"],
        filename: json["filename"],
        path: json["path"],
        score: json["score"].toDouble(),
        startCoordinate: StartCoordinate.fromMap(json["startCoordinate"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "filename": filename,
        "path": path,
        "score": score,
        "startCoordinate": startCoordinate.toMap(),
      };
}

class StartCoordinate {
  StartCoordinate({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  StartCoordinate copyWith({
    required double lat,
    required double lng,
  }) =>
      StartCoordinate(
        lat: lat,
        lng: lng,
      );

  factory StartCoordinate.fromMap(Map<String, dynamic> json) => StartCoordinate(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}
