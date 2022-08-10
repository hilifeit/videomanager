class VideoSetting {
  VideoSetting(
      {required this.videoQuality,
      required this.allowMinMapFScreen,
      required this.videoFScreen,
      required this.videourl});

  int videoQuality;
  bool allowMinMapFScreen;
  bool videoFScreen;
  String videourl;

  VideoSetting copyWith(
          {required int videoQuality,
          required bool allowMinMapFScreen,
          required bool videoFScreen,
          required String videourl}) =>
      VideoSetting(
        videoQuality: videoQuality,
        allowMinMapFScreen: allowMinMapFScreen,
        videoFScreen: videoFScreen,
        videourl: videourl,
      );

  factory VideoSetting.fromJson(Map<String, dynamic> json) => VideoSetting(
        videoQuality: json["videoQuality"],
        allowMinMapFScreen: json["allowMinMapFScreen"],
        videoFScreen: json["videoFScreen"],
        videourl: json["videourl"],
      );

  Map<String, dynamic> toJson() => {
        "videoQuality": videoQuality,
        "allowMinMapFScreen": allowMinMapFScreen,
        "videoFScreen": videoFScreen,
        "videourl": videourl,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is VideoSetting &&
        other.videoQuality == videoQuality &&
        other.allowMinMapFScreen == allowMinMapFScreen &&
        other.videoFScreen == videoFScreen &&
        other.videourl == videourl;
  }

  @override
  int get hashCode => super.hashCode;
}
