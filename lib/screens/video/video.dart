import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/services/dualvideo.dart';

class CustomVideo extends StatefulHookConsumerWidget {
  const CustomVideo({Key? key, required this.leftFile, required this.rightFile})
      : super(key: key);

  final FileDetail leftFile, rightFile;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomVideoState();
}

class _CustomVideoState extends ConsumerState<CustomVideo> {
  @override
  void initState() {
    super.initState();
    var dualVideoService = ref.read(dualVideoServiceProvider);

    var timeData =
        dualVideoService.calculateStartTime(widget.leftFile, widget.rightFile);
    if (UniversalPlatform.isDesktop) {
      VideoDimensions dimension = const VideoDimensions(1920, 1080);

      Media mediaLeft = Media.network(
          widget.leftFile.foundPath.replaceAll(" ", "%20"),
          startTime: Duration.zero + timeData.leftStart,
          stopTime: dualVideoService
                  .getTimeinDuration(widget.leftFile.info.duration) +
              timeData.leftEnd,
          parse: true);

      Media mediaRight = Media.network(
          widget.rightFile.foundPath.replaceAll(" ", "%20"),
          startTime: Duration.zero + timeData.rightStart,
          stopTime: dualVideoService
                  .getTimeinDuration(widget.rightFile.info.duration) +
              timeData.rightEnd,
          parse: true);

      // print('${timeData.leftStart} ${timeData.leftEnd}');
      // print('${timeData.rightStart} ${timeData.rightEnd}');

      // print('${mediaRight.startTime}${mediaRight.stopTime}');
      Duration finalDuration = mediaLeft.stopTime - mediaLeft.startTime;
      dualVideoService.desktop1.value = PlayerController(
          player: Player(
              // id: widget.leftFile.foundPath.length,
              id: 100,
              videoDimensions: dimension),
          duration: finalDuration);

      dualVideoService.desktop2.value = PlayerController(
          player: Player(
              // id: widget.rightFile.foundPath.length,
              id: 200,
              videoDimensions: dimension),
          duration: finalDuration);

      dualVideoService.desktop1.value!.player.open(mediaLeft, autoStart: false);
      dualVideoService.desktop2.value!.player
          .open(mediaRight, autoStart: false);
    } else {
      dualVideoService.web1.value = VideoPlayerController.network(
        widget.leftFile.foundPath,
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((e) {
          print(e);
        });
      dualVideoService.web2.value =
          VideoPlayerController.network(widget.rightFile.foundPath)
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
    final dualVideoService = ref.watch(dualVideoServiceProvider);
    final _controller1 = dualVideoService.web1.value;
    final _controller2 = dualVideoService.web2.value;
    final player1 = dualVideoService.desktop1.value;
    final player2 = dualVideoService.desktop2.value;
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
                          isFirst: false,
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
    ref.read(dualVideoServiceProvider).dispose();
    // if (UniversalPlatform.isDesktop) {
    //   player1!.player.dispose();
    //   player2!.player.dispose();
    // } else {
    //   _controller1!.dispose();
    //   _controller2!.dispose();
    // }
    super.dispose();
  }
}
