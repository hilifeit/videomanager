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

    factory LocationSetting.fromJson(Map<String, dynamic> json) => LocationSetting(
        starvaFile: json["starvaFile"],
    );

    Map<String, dynamic> toJson() => {
        "starvaFile": starvaFile,
    };
}