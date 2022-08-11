import 'dart:html'
    if (dart.library.io) "package:videomanager/screens/others/fakeClasses.dart"
    show VideoElement, window;
import 'dart:io';
import 'dart:typed_data';

import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/videosidebar.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/timeline.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singleplayervideocontroller.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singlevideoplayer.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/components/screenshotscreen.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

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

  late Media media;

  VideoDimensions dimension = const VideoDimensions(1920, 1080);
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
      return null;
    }
    var controller = VideoPlayerController.network(
      getVideoUrl(videoFile.id),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      }).catchError((e) {});

    return controller;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

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
                        child: CustomVideoPlayer(
                          player: player == null ? null : player!.player,
                          controller: controller,
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
                        SingleVideoPlayerControls(
                          desktop: player,
                          web: controller,
                        ),
                        const Spacer(),
                        Text(
                          'FileName',
                          style: kTextStyleInterMedium.copyWith(
                            fontSize: 18.ssp(),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 43.sw(),
                        ),
                        InkWell(
                          onTap: () async {
                            if (CustomOverlayEntry().videoTimeStampOpen) {
                              CustomOverlayEntry().closeVideoTimeStamp();
                            }

                            try {
                              CustomOverlayEntry().showLoader();

                              var ms = 0;
                              if (UniversalPlatform.isDesktop) {
                                ms = player!
                                    .player.position.position!.inMilliseconds;
                              } else {
                                ms = controller!.value.position.inMilliseconds;
                              }
                              var videoDataService =
                                  ref.read(videoDataDetailServiceProvider);
                              try {
                                if (!videoDataService.checkAndAddSnap(ms)) {
                                  snack.info("Screenshot already taken!");
                                  CustomOverlayEntry().closeLoader();
                                } else {
                                  Uint8List image = await ref
                                      .read(fileDetailMiniServiceProvider)
                                      .getFrameFromUrl(
                                          url: getVideoUrl(videoFile.id),
                                          positionInMs: ms);

                                  await videoDataService.selectedSnap.value
                                      ?.decodeImage(image);
                                  CustomOverlayEntry().closeLoader();

                                  Future.delayed(Duration(milliseconds: 10),
                                      () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ScreenShotScreen();
                                    }));
                                  });

                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return ScreenShotScreen();
                                  //     });
                                }
                              } catch (e) {
                                videoDataService.cancelNewSnap();
                                CustomOverlayEntry().closeLoader();
                                snack.info("Try again");
                              }
                            } catch (e, s) {
                              print("$e $context");
                              CustomOverlayEntry().closeLoader();
                              snack.error(e);
                            }
                          },
                          child: Container(
                            width: 50.sr(),
                            height: 50.sr(),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(right: 3.sw(), bottom: 3.sh()),
                            child: Icon(
                              Videomanager.camera,
                              color: Theme.of(context).primaryColor,
                              size: 24.ssp(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 32.sw(),
                        ),
                        CustomElevatedButton(
                          width: 120.sw(),
                          height: 40.sw(),
                          color: Colors.white,
                          onPressedElevated: () {},
                          elevatedButtonText: "Submit",
                          elevatedButtonTextStyle:
                              kTextStyleInterMedium.copyWith(
                            fontSize: 20.ssp(),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 47.sw(),
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
