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
    this.color,
  });

  String? shopName;
  String? category;
  int? shopSize;
  int? phone;
  int? roadFaceNum;
  Color? color;

  Shop copyWith({
    String? shopName,
    String? category,
    int? shopSize,
    int? phone,
    int? roadFace,
    Color? color,
  }) =>
      Shop(
        shopName: shopName,
        category: category,
        shopSize: shopSize,
        phone: phone,
        roadFaceNum: roadFace,
        color: color,
      );

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        shopName: json["shopName"],
        category: json["category"],
        shopSize: json["shopSize"],
        phone: json["phone"],
        roadFaceNum: json["roadFace"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "category": category,
        "shopSize": shopSize,
        "phone": phone,
        "roadFace": roadFaceNum,
        "color": color,
      };
}
