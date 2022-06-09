import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.network(
        'http://192.168.1.10:8000/video/long-sample.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller2 = VideoPlayerController.network(
        'http://192.168.1.10:8000/video/long-sample.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    //   _controller.addListener(() {
    //   print(_controller.value.position);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Placeholder(
            fallbackHeight: 101.sm,
            color: Colors.blue,
          ),
          Flexible(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Expanded(flex: 4, child: VideoPlayer(_controller1)),
                    // Expanded(
                    //   flex: 1,
                    //   child: Placeholder(),
                    // )
                  ],
                )),
                Expanded(child: VideoPlayer(_controller2)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: Placeholder(
                          color: Colors.green,
                          fallbackHeight: 50.sm,
                        ),
                      ),
                      Expanded(
                        child: Placeholder(
                          color: Colors.green,
                          fallbackHeight: 50.sm,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Placeholder(
                    color: Colors.red,
                    fallbackHeight: 65.sm,
                  ),
                ),
              ],
            ),
          ),
          // Placeholder(
          //   fallbackHeight: 50.sm,
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller1.value.isPlaying
                ? _controller1.pause()
                : _controller1.play();
            _controller2.value.isPlaying
                ? _controller2.pause()
                : _controller2.play();
          });
        },
        child: Icon(
          _controller1.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }
}
