import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';

class CustomVideo extends StatefulWidget {
  const CustomVideo({Key? key, required this.pathLeft, required this.pathRight})
      : super(key: key);
  final String pathLeft, pathRight;
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<CustomVideo> {
  VideoPlayerController? _controller1, _controller2;
  PlayerController? player1, player2;

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isDesktop) {
      VideoDimensions dimension = const VideoDimensions(1920, 1080);

      Media mediaLeft = Media.network(widget.pathLeft, parse: true);

      Media mediaRight = Media.network(widget.pathRight, parse: true);

      player1 = PlayerController(
          player:
              Player(id: widget.pathLeft.length, videoDimensions: dimension),
          duration: Duration(
              milliseconds: int.parse(mediaLeft.metas["duration"].toString())));

      player2 = PlayerController(
          player:
              Player(id: widget.pathRight.length, videoDimensions: dimension),
          duration: Duration(
              milliseconds:
                  int.parse(mediaRight.metas["duration"].toString())));

      player1!.player.open(mediaLeft, autoStart: false);
      player2!.player.open(mediaRight, autoStart: false);
    } else {
      _controller1 = VideoPlayerController.network(widget.pathLeft)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((e) {
          print(e);
        });
      _controller2 = VideoPlayerController.network(widget.pathRight)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((e) {
          print(e);
        });
    }

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
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            CustomVideoPlayer(
                                controller: _controller1,
                                player: player1?.player),
                            Positioned(
                                top: 20.sh(),
                                left: 19.sw(),
                                child: SizedBox(
                                    width: 105.77.sw(),
                                    height: 38.26.sh(),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: Center(
                                          child: Text(
                                        'Left',
                                        style: kTextStyleInterMedium.copyWith(
                                            color: Colors.white),
                                      )),
                                    )))
                          ],
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: Stack(
                      children: [
                        CustomVideoPlayer(
                            controller: _controller2, player: player2?.player),
                        Positioned(
                            top: 20.sh(),
                            right: 24.32.sw(),
                            child: SizedBox(
                              width: 105.77.sw(),
                              height: 38.26.sh(),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                    child: Text(
                                  'Right',
                                  style: kTextStyleInterMedium.copyWith(
                                      color: Colors.white),
                                )),
                              ),
                            )),
                      ],
                    ),
                  ),
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
                    leftWeb: _controller1,
                    rightWeb: _controller2,
                    leftDesktop: player1,
                    rightDesktop: player2,
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

  Builder CustomVideoPlayer(
      {VideoPlayerController? controller, Player? player}) {
    return Builder(builder: (context) {
      bool buffering = false;
      return StatefulBuilder(builder: (context, setCustomState) {
        if (UniversalPlatform.isDesktop) {
        } else {
          controller!.addListener(() {
            setCustomState(() {
              buffering = controller.value.isBuffering;
            });
          });
        }
        return Stack(
          children: [
            UniversalPlatform.isDesktop
                ? Video(
                    player: player!,
                    showControls: false,
                  )
                : VideoPlayer(controller!),
            if (buffering)
              Positioned.fill(
                  child: Center(
                      child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )))
          ],
        );
      });
    });
  }

  @override
  void dispose() {
    if (UniversalPlatform.isDesktop) {
      player1!.player.dispose();
      player2!.player.dispose();
    } else {
      _controller1!.dispose();
      _controller2!.dispose();
    }
    super.dispose();
  }
}
