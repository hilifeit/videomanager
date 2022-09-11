import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/videosidebar.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/timeline.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singleplayervideocontroller.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singlevideoplayer.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/videoplayerIntent.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';

class ScreenshotDashboard extends HookConsumerWidget {
  ScreenshotDashboard(
      {required this.videoFile, Key? key, required this.thisUser})
      : super(key: key);
  final UserModelMini thisUser;
  final FileDetail videoFile;

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];

  // bool showOverlay = false;

  // ? desktop
  final GlobalKey screenShot = GlobalKey();
  late Media media;

  final VideoDimensions dimension = const VideoDimensions(1920, 1080);
  late PlayerController? player = getDesktopPlayerController();

  late VideoPlayerController? controller = getWebPlayerController();
  PlayerController? getDesktopPlayerController() {
    if (!UniversalPlatform.isDesktop) {
      return null;
    }
    media = Media.network(getVideoUrl(videoFile.id), parse: true);

    var player = PlayerController(
        player: Player(
            id: UniversalPlatform.isDesktop ? media.resource.length : 1511,
            videoDimensions: dimension),
        duration: Duration(
            hours: videoFile.info.duration.hour,
            minutes: videoFile.info.duration.minute,
            seconds: videoFile.info.duration.second,
            milliseconds: videoFile.info.duration.millisecond));
    player.player.open(media, autoStart: false);
    return player;
  }

  VideoPlayerController? getWebPlayerController() {
    if (UniversalPlatform.isDesktop) {
      // _controller = Future.value(null);
      return null;
    }
    var controller = VideoPlayerController.network(
      getVideoUrl(videoFile.id),
    );
    // _controller = controllerFuture();
    return controller;
  }

  // late Future<VideoPlayerController?> _controller;
  Future<VideoPlayerController?> controllerFuture() async {
    if (UniversalPlatform.isDesktop) return Future.value(null);
    await controller!.initialize();
    return controller;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    ScreenshotIntentFunctions().focus.requestFocus();
    return FocusableActionDetector(
      focusNode: ScreenshotIntentFunctions().focus,
      autofocus: true,
      shortcuts: {
        spaceBarKeySet: SpaceIntent(),
        arrowLeftKeySet: ArrowLeftIntent(),
        controlTabKeySet: ControlTabIntent(),
        sKeySet: SKeyIntent(),
        controlAKeySet: ControlAIntent(),
        escKeySet: EscKeyIntent()
      },
      actions: {
        SpaceIntent: CallbackAction(
          onInvoke: (intent) {
            if (ScreenshotIntentFunctions().isSpaceActive) {
              return ScreenshotIntentFunctions().onSpace();
            }
          },
        ),
        ArrowLeftIntent: CallbackAction(onInvoke: (intent) {
          return ScreenshotIntentFunctions().onArrowLeft();
        }),
        ControlTabIntent: CallbackAction(onInvoke: (intent) {
          return ScreenshotIntentFunctions().onControlTab();
        }),
        SKeyIntent: CallbackAction(onInvoke: (intent) {
          return ScreenshotIntentFunctions().onSKey();
        }),
        ControlAIntent: CallbackAction(
          onInvoke: (intent) {
            return ScreenshotIntentFunctions().onControlAKey();
          },
        ),
        EscKeyIntent: CallbackAction(
          onInvoke: (intent) {
            return ScreenshotIntentFunctions().onEscKey();
          },
        )
      },
      child: FutureBuilder(
          future: controllerFuture(),
          builder: (context, snapshot) {
            if (snapshot.hasData || snapshot.data == null) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 14,
                      child: Stack(
                        children: [
                          if (ResponsiveLayout.isDesktop)
                            Column(
                              children: [
                                Expanded(
                                  child: InteractiveViewer(
                                    panEnabled: false,
                                    child: RepaintBoundary(
                                      key: screenShot,
                                      child: CustomVideoPlayer(
                                        player: player == null
                                            ? null
                                            : player!.player,
                                        controller: controller,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  height: 58.sh(),
                                )
                              ],
                            ),
                          if (ResponsiveLayout.isDesktop &&
                              thisUser.role < Roles.superAdmin.index)
                            Timeline(
                              size: size,
                              duration: getDuration(),
                              desktop: player,
                              web: controller,
                            ),
                          if (!ResponsiveLayout.isDesktop)
                            VideoSideBar(thisUser: thisUser),
                        ],
                      ),
                    ),
                    if (ResponsiveLayout.isDesktop)
                      Container(
                        height: 73.sh(),
                        color: primaryColor,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 51.sw(),
                                  ),
                                  Expanded(
                                    child: SingleVideoPlayerControls(
                                      videoFile: videoFile,
                                      desktop: player,
                                      web: controller,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              child: LinearProgressIndicator(
                                value: 0.3,
                                backgroundColor: Colors.transparent,
                                color: successColor,
                                minHeight: 4.sh(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Duration getDuration() {
    late Duration duration;
    if (UniversalPlatform.isDesktop) {
      duration = player!.duration;
    } else {
      duration = controller!.value.duration;
    }

    return duration;
  }
}
