import 'dart:convert';

import 'package:videomanager/screens/settings/screens/locationsettings/models/locationsetting.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting.dart';
import 'package:videomanager/screens/settings/screens/usersettings/models/usersetting.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));

String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    required this.videoSetting,
    required this.userSetting,
    required this.locationSetting,
    required this.mapSetting,
  });

  final MapSetting mapSetting;
  final VideoSetting videoSetting;
  final UserSetting userSetting;
  final LocationSetting locationSetting;

  Setting copyWith({
    required MapSetting mapSetting,
    required VideoSetting videoSetting,
    required UserSetting userSetting,
    required LocationSetting locationSetting,
  }) =>
      Setting(
        mapSetting: mapSetting,
        videoSetting: videoSetting,
        userSetting: userSetting,
        locationSetting: locationSetting,
      );

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        mapSetting: MapSetting.fromJson(json["mapSetting"]),
        videoSetting: VideoSetting.fromJson(json["videoSetting"]),
        userSetting: UserSetting.fromJson(json["userSetting"]),
        locationSetting: LocationSetting.fromJson(json["locationSetting"]),
      );

  Map<String, dynamic> toJson() => {
        "mapSetting": mapSetting.toJson(),
        "videoSetting": videoSetting.toJson(),
        "userSettings": userSetting.toJson(),
        "locationSettings": locationSetting.toJson()
      };
}
