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
    required this.shopName,
    required this.category,
    required this.shopSize,
    required this.color,
  });

  String shopName;
  String category;
  String shopSize;
  Color color;

  Shop copyWith({
    required String shopName,
    required String category,
    required String shopSize,
    required Color color,
  }) =>
      Shop(
        shopName: shopName,
        category: category,
        shopSize: shopSize,
        color: color,
      );

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        shopName: json["shopName"],
        category: json["category"],
        shopSize: json["shopSize"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "category": category,
        "shopSize": shopSize,
        "color": color,
      };
}
