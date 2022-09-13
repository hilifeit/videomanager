// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'dart:convert';

import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

List<CountryState> countryStatesFromJson(String str) => List<CountryState>.from(
    json.decode(str).map((x) => CountryState.fromJson(x)));

String countryStatesToJson(List<CountryState> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryState {
  CountryState({
    required this.type,
    required this.coordinates,
  }) {
    boundingBox = boundingBoxOffset(coordinates);
  }

  final String type;
  final List<List<double>> coordinates;
  Rect? boundingBox;
  final List<FileDetailMini> files = [];
  CountryState copyWith({
    required String type,
    required List<List<double>> coordinates,
  }) =>
      CountryState(
        type: type,
        coordinates: coordinates,
      );

  factory CountryState.fromJson(Map<String, dynamic> json) => CountryState(
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
