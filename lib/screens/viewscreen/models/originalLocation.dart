import 'package:videomanager/screens/others/exporter.dart';

List<OriginalLocation> originalLocationFromJson(String str) =>
    List<OriginalLocation>.from(
        json.decode(str).map((x) => OriginalLocation.fromJson(x)));

String originalLocationToJson(List<OriginalLocation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OriginalLocation {
  OriginalLocation({
    required this.lat,
    required this.lng,
    required this.timeStamp,
    required this.duplicate,
  });

  final double lat;
  final double lng;
  final DateTime timeStamp;
  final bool duplicate;

  OriginalLocation copyWith({
    required double lat,
    required double lng,
    required DateTime timeStamp,
    required bool duplicate,
  }) =>
      OriginalLocation(
        lat: lat,
        lng: lng,
        timeStamp: timeStamp,
        duplicate: duplicate,
      );

  factory OriginalLocation.fromJson(Map<String, dynamic> json) =>
      OriginalLocation(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        timeStamp: DateTime.parse(json["timeStamp"]),
        duplicate: json["duplicate"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "timeStamp": timeStamp.toIso8601String(),
        "duplicate": duplicate,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OriginalLocation &&
        other.lat == lat &&
        other.lng == lng &&
        other.timeStamp == timeStamp &&
        other.duplicate == duplicate;
  }

  @override
  int get hashCode => super.hashCode;
}
