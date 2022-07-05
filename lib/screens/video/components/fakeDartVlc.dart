import 'package:videomanager/screens/others/exporter.dart';

class Video extends StatefulWidget {
  const Video({Key? key, this.player, this.showControls}) : super(key: key);
  final dynamic player;
  final bool? showControls;
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DartVLC {
  DartVLC._();
  static initialize() async {
    //fake dart vlc v 1.0
  }
}

class Player {
  Player({this.id, this.videoDimensions});
  int? id;
  VideoDimensions? videoDimensions;
  PlayBackState playback = PlayBackState();
  Stream<PositionState> get positionStream =>
      Stream<PositionState>.value(PositionState());
  open(dynamic data, {bool autoStart = false}) {}
  dispose() {}
  seek(Duration duration) {}
  pause() {}
  play() {}
}

class VideoDimensions {
  const VideoDimensions(int width, int height);
}

class Media {
  Media._();

  static network(dynamic url, {bool parse = false}) {}
  Map<String, dynamic> get metas => {};
}

class PositionState {
  PositionState();
  Duration? get position => Duration.zero;
  listen() {}
}

class PlayBackState {
  PlayBackState();
  bool isPlaying = false;
}
