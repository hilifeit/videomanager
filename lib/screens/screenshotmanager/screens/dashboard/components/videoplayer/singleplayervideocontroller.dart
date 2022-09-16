import 'package:videomanager/screens/others/fakejs.dart'
    if (dart.library.js) "dart:js" as js;

import 'dart:io';
import 'dart:typed_data';

import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/playbackMenu.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinecanvas.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singlevideoplayer.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/components/screenshotscreen.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/videoplayerIntent.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

final timelineZoomProvider = StateProvider<double>((ref) {
  return 0;
});

class SingleVideoPlayerControls extends HookConsumerWidget {
  SingleVideoPlayerControls(
      {required this.videoFile, this.web, this.desktop, Key? key})
      : super(key: key);

  final VideoPlayerController? web;
  final PlayerController? desktop;
  final FileDetail videoFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 15));

    ScreenshotIntentFunctions().onSpace = () {
      videoPlayPause(controller);
    };
    ScreenshotIntentFunctions().onSKey = () async {
      await takeScreenShot(context, ref, controller);
    };
    ScreenshotIntentFunctions().onArrowLeft = () async {
      await rewind(controller);
    };
    final double volume = ref.watch(volumeProvider.state).state;
    final bool mute = ref.watch(mutedProvider.state).state;
    final double zoom = ref.watch(timelineZoomProvider.state).state;

    return Row(
      children: [
        IconButton(
          tooltip: 'Rewind',
          onPressed: () async {
            rewind(controller);
          },
          icon: Icon(
            Videomanager.rewind,
            color: Colors.white,
            size: 21.75.ssp(),
          ),
        ),
        SizedBox(
          width: 30.5.sw(),
        ),
        IconButton(
          tooltip: 'Play/Pause',
          onPressed: () {
            videoPlayPause(controller);
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            size: 30.ssp(),
            color: Colors.white,
            progress: controller,
          ),
        ),
        SizedBox(
          width: 30.5.sw(),
        ),
        IconButton(
          tooltip: 'Mute/Unmute',
          onPressed: () {
            if (volume != 0 && mute) {
              if (UniversalPlatform.isDesktop) {
                desktop!.player.setVolume(volume);
              } else {
                web!.setVolume(volume);
              }

              ref.read(mutedProvider.state).state = false;
            } else if (volume == 0 && mute) {
              ref.read(mutedProvider.state).state = false;
              ref.read(volumeProvider.state).state = 0.2;
              if (UniversalPlatform.isDesktop) {
                desktop!.player.setVolume(volume);
              } else {
                web!.setVolume(volume);
              }
            } else {
              ref.read(mutedProvider.state).state = true;
              if (UniversalPlatform.isDesktop) {
                desktop!.player.setVolume(0);
              } else {
                web!.setVolume(0);
              }
            }
          },
          icon: mute || volume == 0
              ? Icon(
                  Icons.volume_off,
                  color: Colors.white,
                  size: 24.ssp(),
                )
              : Icon(
                  Videomanager.volume,
                  color: Colors.white,
                  size: 22.ssp(),
                ),
        ),
        SizedBox(
          width: 10.sw(),
        ),
        CustomSliderHollowThumb(
            value: mute && volume != 0 ? 0 : volume,
            onChangedEnd: (val) {
              if (val == 0) {
                ref.read(mutedProvider.state).state = true;
              }
            },
            onChanged: (val) {
              ref.read(volumeProvider.state).state = val;
              if (UniversalPlatform.isDesktop) {
                desktop!.player.setVolume(val);
              } else {
                web!.setVolume(val);
              }

              if (volume != 0) {
                ref.read(mutedProvider.state).state = false;
              }
            }),
        SizedBox(
          width: 10.sw(),
        ),
        PlayBackMenu(
          onchanged: (value) {
            if (UniversalPlatform.isDesktop) {
              desktop!.player.setRate(value);
            } else {
              web!.setPlaybackSpeed(value);
            }
          },
        ),
        VideoTime(
          web: web,
          desktop: desktop,
        ),
        SizedBox(
          width: 40.sw(),
        ),
        CustomSliderHollowThumb(
            value: zoom,
            onChangedEnd: (val) {},
            onChanged: (val) {
              ref.read(timelineZoomProvider.state).state = val;
              if (val == 0) {
                ref.read(horizontalDragProvider.state).state = 0;
              }
              print(zoom);

              // ref.read(buttonWidthProvider.state).state = zoom < 0.9
              //     ? MediaQuery.of(context).size.width -
              //         MediaQuery.of(context).size.width * zoom
              //     : MediaQuery.of(context).size.width -
              //         MediaQuery.of(context).size.width * 0.9;
            }),
        const Spacer(),
        Text(
          videoFile.info.filename,
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
            await takeScreenShot(context, ref, controller);
          },
          child: Container(
            width: 50.sr(),
            height: 50.sr(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 3.sw(), bottom: 3.sh()),
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
          elevatedButtonTextStyle: kTextStyleInterMedium.copyWith(
            fontSize: 20.ssp(),
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          width: 47.sw(),
        ),

        // IconButton(
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) {
        //             return Playback(onChanged: (context) {});
        //           });
        //     },
        //     icon: Icon(
        //       Videomanager.settings,
        //       color: Colors.white,
        //       size: 21.75.ssp(),
        //     )),
        SizedBox(
          width: 24.sw(),
        ),
      ],
    );
  }

  rewind(AnimationController controller) async {
    if (UniversalPlatform.isDesktop) {
      desktop!.player.seek(
          ((desktop!.player.position.position!)) - const Duration(seconds: 10));
      if (!desktop!.player.playback.isPlaying) {
        desktop!.player.play();
        controller.forward();
      }
    } else {
      web!.seekTo((await (web!.position))! - const Duration(seconds: 10));
    }
  }

  takeScreenShot(BuildContext context, WidgetRef ref,
      AnimationController controller) async {
    if (UniversalPlatform.isDesktop) {
      if (desktop!.player.playback.isPlaying) {
        desktop!.player.pause();
        controller.reverse();
      }
    } else {
      if (web!.value.isPlaying) {
        web!.pause();
        controller.reverse();
      }
    }
    try {
      var videoDataService = ref.read(videoDataDetailServiceProvider);
      CustomOverlayEntry().showLoader();

      late Duration duration;
      if (UniversalPlatform.isDesktop) {
        duration = desktop!.player.position.position!;
      } else {
        var dur = js.context.callMethod("getCurrentTime", []);
        try {
          duration = Duration(microseconds: dur * 1000 * 1000);
        } catch (e) {
          print(e);
          duration = web!.value.position;
          // duration = Duration(microseconds: dur * 1000 * 1000);
        }
      }
      if (!videoDataService.checkAndAddSnap(duration)) {
        var index = videoDataService.snaps
            .indexWhere(((element) => element.timeStamp == duration));
        Future.delayed(const Duration(milliseconds: 10), () async {
          ScreenshotIntentFunctions().isSpaceActive = false;

          await Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ScreenShotScreen(
              duration: duration,
            );
          }));
          ScreenshotIntentFunctions().isSpaceActive = true;
        });
        CustomOverlayEntry().closeLoader();
      } else {
        Uint8List? image;

        if (UniversalPlatform.isDesktop) {
          File file = File("temp.png");
          desktop!.player.takeSnapshot(file, 854, 480);

          image = file.readAsBytesSync();
        } else {
          var result =
              js.context.callMethod("getFrame", [getVideoUrl(videoFile.id)]);

          if (result == null) print("no image");

          // print("$dur $d $duration");
          try {
            image = const Base64Decoder().convert(result);
          } catch (e) {
            image = await ref
                .read(fileDetailMiniServiceProvider)
                .getFrameFromUrl(id: videoFile.id, duration: duration);
          }
        }

        try {
          // videoDataService.selectedSnap.value?.image = image;
          CustomOverlayEntry().closeLoader();

          if (image == null) return 0;

          Future.delayed(const Duration(milliseconds: 10), () async {
            ScreenshotIntentFunctions().isSpaceActive = false;
            await Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ScreenShotScreen(
                thumb: image,
                id: videoFile.id,
                duration: duration,
              );
            }));
            ScreenshotIntentFunctions().isSpaceActive = true;
          });

          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return ScreenShotScreen();
          //     });

        } catch (e) {
          videoDataService.cancelNewSnap();
          CustomOverlayEntry().closeLoader();
          snack.info("Try again");
        }
      }
    } catch (e, s) {
      print("$e $context");
      CustomOverlayEntry().closeLoader();
      snack.error(e);
    }
  }

  videoPlayPause(AnimationController controller) {
    if (UniversalPlatform.isDesktop) {
      // desktop!.player.open(Media.network(
      //   getVideoUrl("62931b515e4df91e44463cea"),
      // ));
      if (desktop!.player.playback.isPlaying) {
        desktop!.player.pause();
        controller.reverse();
      } else {
        desktop!.player.play();

        controller.forward();
      }
    } else {
      if (web!.value.isPlaying) {
        web!.pause();
        controller.reverse();
      } else {
        web!.play();
        controller.forward();
      }
    }
  }
}

class VideoTime extends StatelessWidget {
  VideoTime({Key? key, this.web, this.desktop}) : super(key: key);
  final VideoPlayerController? web;
  final PlayerController? desktop;

  late final Duration length;

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isDesktop) {
      length = desktop!.duration;
      // ref.read(timeProvider.state).state = desktop!.player.position.position!;

      return StreamBuilder<PositionState>(
          initialData: PositionState(),
          stream: desktop!.player.positionStream,
          builder: (context, snapshot) {
            return videoTime(snapshot.data!.position!, length);
          });
    } else {
      length = web!.value.duration;
      return ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: web!,
          builder: (context, value, child) {
            return videoTime(value.position, length);
          });
    }
  }

  Widget videoTime(Duration current, Duration length) {
    return Text(
      '${intToTime(current.inSeconds)} / ${intToTime(length.inSeconds)}',
      style: kTextStyleInterMedium.copyWith(
          fontSize: 14.ssp(), color: const Color(0xffeaeaea).withAlpha(180)),
    );
  }
}
