// To parse this JSON data, do
//
//     final mapSetting = mapSettingFromJson(jsonString);

import 'dart:convert';

MapSetting mapSettingFromJson(String str) =>
    MapSetting.fromJson(json.decode(str));

String mapSettingToJson(MapSetting data) => json.encode(data.toJson());

class MapSetting {
  MapSetting({
    required this.zoom,
    required this.stroke,
    required this.scroll,
    required this.sample,
    required this.defaultLocation,
    required this.filterCount,
  });

  double zoom;
  double stroke;
  double scroll;
  Sample sample;
  DefaultLocation defaultLocation;
  int filterCount;

  MapSetting copyWith({
    required double zoom,
    required double stroke,
    required double scroll,
    required Sample sample,
    required DefaultLocation defaultLocation,
    required int filterCount,
  }) =>
      MapSetting(
        zoom: zoom,
        stroke: stroke,
        scroll: scroll,
        sample: sample,
        defaultLocation: defaultLocation,
        filterCount: filterCount,
      );

  factory MapSetting.fromJson(Map<String, dynamic> json) => MapSetting(
        zoom: json["zoom"].toDouble(),
        stroke: json["stroke"].toDouble(),
        scroll: json["scroll"].toDouble(),
        sample: Sample.fromJson(json["sample"]),
        defaultLocation: DefaultLocation.fromJson(json["defaultLocation"]),
        filterCount: json["filterCount"],
      );

  Map<String, dynamic> toJson() => {
        "zoom": zoom,
        "stroke": stroke,
        "scroll": scroll,
        "sample": sample.toJson(),
        "defaultLocation": defaultLocation.toJson(),
        "filterCount": filterCount,
      };
}

class DefaultLocation {
  DefaultLocation({
    required this.enabled,
    required this.lat,
    required this.lng,
  });

  bool enabled;
  double lat;
  double lng;

  DefaultLocation copyWith({
    required bool enabled,
    required double lat,
    required double lng,
  }) =>
      DefaultLocation(
        enabled: enabled,
        lat: lat,
        lng: lng,
      );

  factory DefaultLocation.fromJson(Map<String, dynamic> json) =>
      DefaultLocation(
        enabled: json["enabled"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "lat": lat,
        "lng": lng,
      };
}

class Sample {
  Sample({
    required this.original,
    required this.view,
    required this.miniMap,
  });

  int original;
  int view;
  int miniMap;

  Sample copyWith({
    required int original,
    required int view,
    required int miniMap,
  }) =>
      Sample(
        original: original,
        view: view,
        miniMap: miniMap,
      );

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        original: json["original"],
        view: json["view"],
        miniMap: json["miniMap"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "view": view,
        "miniMap": miniMap,
      };
}
