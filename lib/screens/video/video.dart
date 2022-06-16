import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';

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
                      Expanded(
                          flex: 4,
                          child: Stack(
                      children: [
                        CustomVideoPlayer(controller: _controller1),
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

                                )),)))
                          ],
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: Stack(
                      children: [
                        CustomVideoPlayer(controller: _controller2),
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

  Builder CustomVideoPlayer({required VideoPlayerController controller}) {
    return Builder(builder: (context) {
      bool buffering = false;
      return StatefulBuilder(builder: (context, setCustomState) {
        controller.addListener(() {
          setCustomState(() {
            buffering = controller.value.isBuffering;
          });
        });
        return Stack(
          children: [
            VideoPlayer(controller),
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
    _controller1.dispose();
    _controller2.dispose();
  }
}
