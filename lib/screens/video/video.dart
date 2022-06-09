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
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(child: VideoPlayer(_controller1)),
                  Expanded(child: VideoPlayer(_controller2)),
                ],
              ),
            ),
            Expanded(
              flex:1, child: Placeholder())
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






// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:video_player/video_player.dart';

// class Video extends StatefulWidget {
//   Video({Key? key}) : super(key: key);

//   @override
//   State<Video> createState() => _VideoState();
// }

// class _VideoState extends State<Video> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = VideoPlayerController.network(
//       'http://192.168.1.10:8000/video/long-sample.mp4',
//     )..initialize().then((value) 
//     {
//         setState(() {});
//         _controller.position.asStream().listen((event) {
//           print(event);
//         });
//         print(_controller.value.position);
//       });
//       _controller.addListener(() {
//       print(_controller.value.position);
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//         body: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : Container());
//   }
// }
