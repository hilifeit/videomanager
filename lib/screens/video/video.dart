import 'package:videomanager/screens/others/exporter.dart';
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
  Player? _player1, _player2;

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isDesktop) {
      VideoDimensions dimension = const VideoDimensions(1920, 1080);
      _player1 = Player(id: widget.pathLeft.length, videoDimensions: dimension);
      _player2 =
          Player(id: widget.pathRight.length, videoDimensions: dimension);

      _player1!.open(Media.network(widget.pathLeft));
      _player2!.open(Media.network(widget.pathRight));
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
                                controller: _controller1, player: _player1),
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
                            controller: _controller2, player: _player2),
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
                    leftDesktop: _player1,
                    rightDesktop: _player2,
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
                    player: player,
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
    super.dispose();
    if (UniversalPlatform.isDesktop) {
      _player1!.dispose();
      _player2!.dispose();
    } else {
      _controller1!.dispose();
      _controller2!.dispose();
    }
  }
}
