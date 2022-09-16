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
  Shop({
    required this.shopName,
    required this.category,
    required this.shopSize,
    this.phone,
    required this.roadFaceNum,
    required this.roadFace,
    required this.color,
    required this.position,
    required this.area,
  });

  String shopName;
  int category;
  int shopSize;
  int? phone;
  int roadFaceNum;
  RoadFace roadFace;
  Color color;
  Offset position;
  List<Offset> area;

  Shop copyWith({
    required String shopName,
    required int category,
    required int shopSize,
    required int phone,
    required int roadFaceNum,
    required RoadFace roadFace,
    required Color color,
    required List<Offset> area,
  }) =>
      Shop(
          shopName: shopName,
          category: category,
          shopSize: shopSize,
          phone: phone,
          roadFaceNum: roadFaceNum,
          roadFace: roadFace,
          color: color,
          position: position,
          area: area);
  static empty() => Shop(
      shopName: '',
      category: 0,
      shopSize: 1,
      roadFaceNum: 1,
      roadFace: RoadFace(roadFace1: 1),
      color: primaryColor,
      position: const Offset(0, 0),
      area: [Offset(0, 0), Offset(20, 0), Offset(20, 20), Offset(0, 20)]);

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
      shopName: json["shopName"],
      category: json["category"],
      shopSize: json["shopSize"],
      phone: json["phone"],
      roadFaceNum: json["roadFaceNum"],
      roadFace: RoadFace.fromJson(json["roadFace"]),
      color: json["color"],
      position: json["position"],
      area: json["position"]);

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "category": category,
        "shopSize": shopSize,
        "phone": phone,
        "roadFaceNum": roadFaceNum,
        "roadFace": roadFace,
        "color": color,
        "position": position,
        "area": area
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Shop &&
        other.shopName == shopName &&
        other.category == category &&
        other.color == color &&
        other.shopSize == shopSize &&
        other.roadFaceNum == roadFaceNum &&
        other.position == position &&
        other.phone == phone &&
        other.area == area &&
        other.roadFace == roadFace;
  }

  @override
  int get hashCode => super.hashCode;
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RoadFace &&
        other.roadFace1 == roadFace1 &&
        other.roadFace2 == roadFace2 &&
        other.roadFace3 == roadFace3;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
