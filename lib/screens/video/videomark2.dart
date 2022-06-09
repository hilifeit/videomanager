import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerMark2 extends StatefulWidget {
  const VideoPlayerMark2({Key? key}) : super(key: key);

  @override
  State<VideoPlayerMark2> createState() => _VideoPlayerMark2State();
}

class _VideoPlayerMark2State extends State<VideoPlayerMark2> {
  final VideoPlayerController videoPlayerController1 =
      VideoPlayerController.network(
          "http://192.168.1.10:8000/video/long-sample.mp4");
  final VideoPlayerController videoPlayerController2 =
      VideoPlayerController.network(
          "http://192.168.1.10:8000/video/long-sample.mp4");

  ChewieController? chewieController1;
    ChewieController? chewieController2;


  // init State
  @override
  void initState() {
    chewieController1 = ChewieController(
      videoPlayerController: videoPlayerController1,
      //aspectRatio: 1,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      showControls: false,
      maxScale: 5
      // startAt: Duration(minutes: 1),
    );
    chewieController2 = ChewieController(
      videoPlayerController: videoPlayerController2,
     // aspectRatio: 1,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      showControls: false,
      // startAt: Duration(minutes: 1),
    );
    super.initState();
    // videoPlayerController.addListener(() {
    //   print(videoPlayerController.value.position);
    // });
  }

  @override
  void dispose() {
    videoPlayerController1.dispose();
    videoPlayerController2.dispose();
    chewieController1!.dispose();
    chewieController2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              videoPlayerController1.value.isPlaying
                  ? videoPlayerController1.pause() 
                  : videoPlayerController1.play();
            });
            setState(() {
              videoPlayerController2.value.isPlaying
                  ? videoPlayerController2.pause() 
                  : videoPlayerController2.play();
            });
          },
          child: Icon(
            videoPlayerController1.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(child: Chewie(controller: chewieController1!)),
                    Expanded(child: Chewie(controller: chewieController2!)),
                    
                
                  ],
                ),
               
              ],
            ),
          ),
          Expanded(child: Placeholder())
        ],
      ),
    );
  }
}
