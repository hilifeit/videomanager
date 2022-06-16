import 'dart:convert';

import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting.dart';

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));

String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    required this.mapSetting,
  });

  final MapSetting mapSetting;

  Setting copyWith({
    required MapSetting mapSetting,
  }) =>
      Setting(
        mapSetting: mapSetting,
      );

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        mapSetting: MapSetting.fromJson(json["mapSetting"]),
      );

  Map<String, dynamic> toJson() => {
        "mapSetting": mapSetting.toJson(),
      };
}
