import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';

class StartEndTime {
  late Duration leftStart, leftEnd, rightStart, rightEnd;
}

class CustomVideo extends StatefulWidget {
  const CustomVideo({Key? key, required this.leftFile, required this.rightFile})
      : super(key: key);

  final FileDetail leftFile, rightFile;
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<CustomVideo> {
  VideoPlayerController? _controller1, _controller2;
  PlayerController? player1, player2;

  @override
  void initState() {
    super.initState();
    var timeData = calculateStartTime(widget.leftFile, widget.rightFile);
    if (UniversalPlatform.isDesktop) {
      VideoDimensions dimension = const VideoDimensions(1920, 1080);

      Media mediaLeft = Media.network(
          widget.leftFile.foundPath.replaceAll(" ", "%20"),
          startTime: Duration.zero + timeData.leftStart,
          stopTime: getTimeinDuration(widget.leftFile.info.duration) +
              timeData.leftEnd,
          parse: true);

      Media mediaRight = Media.network(
          widget.rightFile.foundPath.replaceAll(" ", "%20"),
          startTime: Duration.zero + timeData.rightStart,
          stopTime: getTimeinDuration(widget.rightFile.info.duration) +
              timeData.rightEnd,
          parse: true);

      // print('${timeData.leftStart} ${timeData.leftEnd}');
      // print('${timeData.rightStart} ${timeData.rightEnd}');

      // print('${mediaRight.startTime}${mediaRight.stopTime}');
      Duration finalDuration = mediaLeft.stopTime - mediaLeft.startTime;
      player1 = PlayerController(
          player: Player(
              id: widget.leftFile.foundPath.length, videoDimensions: dimension),
          duration: finalDuration);

      player2 = PlayerController(
          player: Player(
              id: widget.rightFile.foundPath.length,
              videoDimensions: dimension),
          duration: finalDuration);

      player1!.player.open(mediaLeft, autoStart: false);
      player2!.player.open(mediaRight, autoStart: false);
    } else {
      _controller1 = VideoPlayerController.network(
        widget.leftFile.foundPath,
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((e) {
          print(e);
        });
      _controller2 = VideoPlayerController.network(widget.rightFile.foundPath)
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
                    children: [
                      Expanded(
                        child: VideoDetails(
                          isDetailed: true,
                          detailedFile: widget.leftFile,
                        ),
                      ),
                      Expanded(
                        child: VideoDetails(
                          isDetailed: true,
                          detailedFile: widget.rightFile,
                        ),
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

  StartEndTime calculateStartTime(FileDetail left, FileDetail right) {
    StartEndTime data = StartEndTime();
    var leftEndinDuration = getTimeinDuration(left.info.modifiedDate);
    var rightEndinDuration = getTimeinDuration(right.info.modifiedDate);

    var leftStartinDuration = getTimeinDuration(
        left.info.modifiedDate.subtract(getTimeinDuration(left.info.duration)));
    var rightStartinDuration = getTimeinDuration(right.info.modifiedDate
        .subtract(getTimeinDuration(right.info.duration)));

    if (leftStartinDuration > rightStartinDuration) {
      data.leftStart = Duration.zero;
      data.rightStart = leftStartinDuration - rightStartinDuration;
    } else if (leftStartinDuration == rightStartinDuration) {
      data.leftStart = Duration.zero;
      data.rightStart = Duration.zero;
    } else {
      data.leftStart = rightStartinDuration - leftStartinDuration;
      data.rightStart = Duration.zero;
    }

    if (leftEndinDuration < rightEndinDuration) {
      data.leftEnd = Duration.zero;
      data.rightEnd = leftEndinDuration - rightEndinDuration;
    } else if (leftEndinDuration == rightEndinDuration) {
      data.leftEnd = Duration.zero;
      data.rightEnd = Duration.zero;
    } else {
      data.leftEnd = rightEndinDuration - leftEndinDuration;
      data.rightEnd = Duration.zero;
    }
    return data;
  }

  Duration getTimeinDuration(DateTime date) {
    return Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
        milliseconds: date.millisecond);
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
