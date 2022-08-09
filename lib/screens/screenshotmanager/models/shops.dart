// To parse this JSON data, do
//
//     final userModelMini = userModelMiniFromJson(jsonString);

import 'dart:convert';

import 'package:videomanager/screens/others/exporter.dart';

List<Shop> shopFromJson(String str) =>
    List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

Shop shopModelMiniFromJson(String str) => Shop.fromJson(json.decode(str));

String shopModelMiniToJson(Shop data) => json.encode(data.toJson());

class Shop {
  Shop(
      {required this.shopName,
      required this.category,
      required this.shopSize,
      this.phone,
      required this.roadFaceNum,
      required this.roadFace,
      required this.color,
      required this.position});

  String shopName;
  String category;
  int shopSize;
  int? phone;
  int roadFaceNum;
  RoadFace roadFace;
  Color color;
  Offset position;

  Shop copyWith({
    required String shopName,
    required String category,
    required int shopSize,
    required int phone,
    required int roadFaceNum,
    required RoadFace roadFace,
    required Color color,
  }) =>
      Shop(
          shopName: shopName,
          category: category,
          shopSize: shopSize,
          phone: phone,
          roadFaceNum: roadFaceNum,
          roadFace: roadFace,
          color: color,
          position: position);
  static empty() => Shop(
      shopName: '',
      category: '',
      shopSize: 0,
      roadFaceNum: 1,
      roadFace: RoadFace(roadFace1: 1),
      color: primaryColor,
      position: const Offset(0, 0));

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
      shopName: json["shopName"],
      category: json["category"],
      shopSize: json["shopSize"],
      phone: json["phone"],
      roadFaceNum: json["roadFaceNum"],
      roadFace: RoadFace.fromJson(json["roadFace"]),
      color: json["color"],
      position: json["position"]);

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "category": category,
        "shopSize": shopSize,
        "phone": phone,
        "roadFaceNum": roadFaceNum,
        "roadFace": roadFace,
        "color": color,
        "position": position
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
