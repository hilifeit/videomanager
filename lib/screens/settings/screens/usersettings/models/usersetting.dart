class UserSetting {
    UserSetting({
        required this.videoPerUser,
    });

     int videoPerUser;

    UserSetting copyWith({
        required int videoPerUser,
    }) => 
        UserSetting(
            videoPerUser: videoPerUser,
        );

    factory UserSetting.fromJson(Map<String, dynamic> json) => UserSetting(
        videoPerUser: json["videoPerUser"],
    );

    Map<String, dynamic> toJson() => {
        "videoPerUser": videoPerUser,
    };
}