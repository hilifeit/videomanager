import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';

import 'package:videomanager/screens/video/components/videoplayercontrols.dart';
import 'package:videomanager/videomanager_icons.dart';

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
          Flexible(
            flex: 6,
            child: Container(
              color: Colors.black,
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
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: const [
                       Expanded(
                        child: VideoDetails(),
                      ),
                       Expanded(
                        child: VideoDetails(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: VideoPlayerControls(
                    left: _controller1,
                    right: _controller2,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }
}
