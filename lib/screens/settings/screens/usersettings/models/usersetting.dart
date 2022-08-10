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
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is UserSetting && other.videoPerUser == videoPerUser;
  }

  @override
  int get hashCode => super.hashCode;
}
