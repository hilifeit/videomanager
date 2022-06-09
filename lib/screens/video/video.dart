import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
      'http://192.168.1.10:8000/video/long-sample.mp4',
    )..initialize().then((value) {
        setState(() {});
        _controller.position.asStream().listen((event) {
          print(event);
        });
        print(_controller.value.position);
      });
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      print('here');
    });
    return Scaffold(
        body: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container());
  }
}
