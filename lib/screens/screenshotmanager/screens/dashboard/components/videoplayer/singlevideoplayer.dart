import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:videomanager/screens/others/exporter.dart';

final volumeProvider = StateProvider<double>((ref) {
  return 0.5;
});
final mutedProvider = StateProvider<bool>((ref) {
  return false;
});
final timeProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

class CustomVideoPlayer extends StatelessWidget {
  CustomVideoPlayer({Key? key, this.player, this.controller}) : super(key: key);
  final Player? player;
  final VideoPlayerController? controller;
  final GlobalKey skey = GlobalKey();
  bool buffering = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("here");
        // final boundary =
        //     skey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
        // final image = await boundary?.toImage();
        // final byteData = await image?.toByteData(format: ImageByteFormat.png);
        // final imageBytes = byteData?.buffer.asUint8List();

        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         content: imageBytes == null
        //             ? Text("No image")
        //             : Image.memory(imageBytes!),
        //       );
        //     });
      },
      child: Stack(
        children: [
          UniversalPlatform.isDesktop
              ? RepaintBoundary(
                  key: skey,
                  child: Video(
                    player: player,
                    showControls: false,
                  ),
                )
              : RepaintBoundary(key: skey, child: VideoPlayer(controller!)),
          if (buffering)
            Positioned.fill(
                child: Center(
                    child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )))
        ],
      ),
    );
  }
}
