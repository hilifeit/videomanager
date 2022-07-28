// To parse this JSON data, do
//
//     final userModelMini = userModelMiniFromJson(jsonString);

import 'dart:convert';

import 'package:videomanager/screens/others/exporter.dart';

List<Shop> shopFromJson(String str) =>
    List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

Shop userModelMiniFromJson(String str) => Shop.fromJson(json.decode(str));

String userModelMiniToJson(Shop data) => json.encode(data.toJson());

class Shop {
  Shop({
    this.shopName,
    this.category,
    this.shopSize,
    this.phone,
    this.roadFaceNum,
    this.roadFace,
    this.color,
  });

  String? shopName;
  String? category;
  int? shopSize;
  int? phone;
  int? roadFaceNum;
  RoadFace? roadFace;
  Color? color;

  Shop copyWith({
    String? shopName,
    String? category,
    int? shopSize,
    int? phone,
    int? roadFaceNum,
    RoadFace? roadFace,
    Color? color,
  }) =>
      Shop(
        shopName: shopName,
        category: category,
        shopSize: shopSize,
        phone: phone,
        roadFaceNum: roadFaceNum,
        roadFace: roadFace,
        color: color,
      );

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        shopName: json["shopName"],
        category: json["category"],
        shopSize: json["shopSize"],
        phone: json["phone"],
        roadFaceNum: json["roadFaceNum"],
        roadFace: RoadFace.fromJson(json["superVisor"]),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "category": category,
        "shopSize": shopSize,
        "phone": phone,
        "roadFaceNum": roadFaceNum,
        "roadFace": roadFace != null ? roadFace!.toJson() : null,
        "color": color,
      };
}

class RoadFace {
  RoadFace({
    required this.roadFace1,
    this.roadFace2,
    this.roadFace3,
  });

  int roadFace1;
  int? roadFace2;
  int? roadFace3;

  RoadFace copyWith({
    required int roadFace1,
    int? roadFace2,
    int? roadFace3,
  }) =>
      RoadFace(
        roadFace1: roadFace1,
        roadFace2: roadFace2,
        roadFace3: roadFace3,
      );

  factory RoadFace.fromJson(Map<String, dynamic> json) => RoadFace(
        roadFace1: json["_roadFace1"],
        roadFace2: json["roadFace2"],
        roadFace3: json["roadFace3"],
      );

  Map<String, dynamic> toJson() => {
        "roadFace1": roadFace1,
        "roadFace2": roadFace2,
        "roadFace3": roadFace3,
      };
}
