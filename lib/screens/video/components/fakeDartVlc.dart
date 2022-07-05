import 'package:videomanager/screens/others/exporter.dart';

class Video extends StatefulWidget {
  const Video({Key? key, required this.player}) : super(key: key);
  final String player;
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
  Player({this.id = '', this.videoDimensions});
  String id;
  VideoDimensions? videoDimensions;
}

class VideoDimensions {
  VideoDimensions(int width, int height);
}
