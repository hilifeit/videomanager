class LocationSetting {
  LocationSetting({
    required this.starvaFile,
  });

  bool starvaFile;

  LocationSetting copyWith({
    required bool starvaFile,
  }) =>
      LocationSetting(
        starvaFile: starvaFile,
      );

  factory LocationSetting.fromJson(Map<String, dynamic> json) =>
      LocationSetting(
        starvaFile: json["starvaFile"],
      );

  Map<String, dynamic> toJson() => {
        "starvaFile": starvaFile,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is LocationSetting && other.starvaFile == starvaFile;
  }

  @override
  int get hashCode => super.hashCode;
}
