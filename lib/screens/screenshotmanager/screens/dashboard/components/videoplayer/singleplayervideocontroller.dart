import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/playback.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/playbackMenu.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singlevideoplayer.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';

class SingleVideoPlayerControls extends HookConsumerWidget {
  SingleVideoPlayerControls({this.web, this.desktop, Key? key})
      : super(key: key);

  final VideoPlayerController? web;
  final PlayerController? desktop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 15));

    final double volume = ref.watch(volumeProvider.state).state;
    final bool mute = ref.watch(mutedProvider.state).state;
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            if (UniversalPlatform.isDesktop) {
              desktop!.player.seek(((desktop!.player.position.position!)) -
                  const Duration(seconds: 10));
              if (!desktop!.player.playback.isPlaying) {
                desktop!.player.play();
                controller.forward();
              }
            } else {
              web!.seekTo(
                  (await (web!.position))! - const Duration(seconds: 10));
            }
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
          onPressed: () {
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
          onchanged: (p0) {
            print(p0);
          },
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
        // VideoTime(
        //   web: web,
        //   desktop: desktop,
        // ),
      ],
    );
  }
}

class VideoTime extends ConsumerWidget {
  VideoTime({Key? key, this.web, this.desktop}) : super(key: key);
  final VideoPlayerController? web;
  final PlayerController? desktop;
  double maxSliderValue = 100;
  double progress = 0;
  late Duration length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(timeProvider.state).state;
    if (UniversalPlatform.isDesktop) {
      length = desktop!.duration;
      ref.read(timeProvider.state).state = desktop!.player.position.position!;
      desktop!.player.positionStream.listen((event) {
        ref.read(timeProvider.state).state = event.position!;
      });
    } else {
      length = web!.value.duration;
      ref.read(timeProvider.state).state = web!.value.position;
      web!.addListener(() {
        ref.read(timeProvider.state).state = web!.value.position;
      });
    }

    return Text(
      '${intToTime(current.inSeconds)} / ${intToTime(length.inSeconds)}',
      style: kTextStyleInterMedium.copyWith(
          fontSize: 14.ssp(), color: const Color(0xffeaeaea).withAlpha(180)),
    );
  }
}
