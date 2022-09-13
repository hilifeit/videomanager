import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'dart:convert';

import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States._({
    required this.type,
    required this.states,
  });

  final String type;
  final List<State> states;

  States copyWith({
    required String type,
    required List<State> states,
  }) =>
      States._(
        type: type,
        states: states,
      );

  factory States.fromJson(Map<String, dynamic> json) => States._(
        type: json["type"],
        states:
            List<State>.from(json["features"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class State {
  State({
    required this.type,
    required this.properties,
    required this.geometry,
  }) {
    try {
      // print(geometry.coordinates.first);
      boundingBox = boundingBoxOffset(geometry.coordinates.first);
    } catch (e, s) {
      print("$e $s");
    }
  }

  final String type;
  final Properties properties;
  final Geometry geometry;
  Rect? boundingBox;
  final List<FileDetailMini> files = [];

  State copyWith({
    required String type,
    required Properties properties,
    required Geometry geometry,
  }) =>
      State(
        type: type,
        properties: properties,
        geometry: geometry,
      );

  factory State.fromJson(Map<String, dynamic> json) => State(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<List<List<dynamic>>> coordinates;

  Geometry copyWith({
    required String type,
    required List<List<List<dynamic>>> coordinates,
  }) =>
      Geometry(
        type: type,
        coordinates: coordinates,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<List<dynamic>>>.from(json["coordinates"].map(
            (x) => List<List<dynamic>>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) =>
            List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}

class Properties {
  Properties({
    required this.id,
    required this.name,
    required this.capital,
  });

  final int id;
  final String name;
  final String capital;

  Properties copyWith({
    required int id,
    required String name,
    required String capital,
  }) =>
      Properties(
        id: id,
        name: name,
        capital: capital,
      );

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"],
        name: json["name"],
        capital: json["capital"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "capital": capital,
      };
}
