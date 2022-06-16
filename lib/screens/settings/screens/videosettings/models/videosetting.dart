

class VideoSetting {
    VideoSetting({
        required this.videoQuality,
        required this.allowMinMapFScreen,
        required this.videoFScreen,
    });

     int videoQuality;
     bool allowMinMapFScreen;
     bool videoFScreen;

    VideoSetting copyWith({
        required int videoQuality,
        required bool allowMinMapFScreen,
        required bool videoFScreen,
    }) => 
        VideoSetting(
            videoQuality: videoQuality ,
            allowMinMapFScreen: allowMinMapFScreen ,
            videoFScreen: videoFScreen ,
        );

    factory VideoSetting.fromJson(Map<String, dynamic> json) => VideoSetting(
        videoQuality: json["videoQuality"],
        allowMinMapFScreen: json["allowMinMapFScreen"],
        videoFScreen: json["videoFScreen"],
    );

    Map<String, dynamic> toJson() => {
        "videoQuality": videoQuality,
        "allowMinMapFScreen": allowMinMapFScreen,
        "videoFScreen": videoFScreen,
    };
}
