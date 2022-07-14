import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';

final volumeProvider = StateProvider<double>((ref) {
  return 0.5;
});
final mutedProvider = StateProvider<bool>((ref) {
  return false;
});

class PlayVideo extends HookConsumerWidget {
  PlayVideo({this.videoFile, Key? key, required this.role}) : super(key: key);
  final int role;
  final FileDetail? videoFile;

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];

  // bool showOverlay = false;

  late OverlayEntry overlayEntry;
  Media media = Media.network(
      "http://192.168.16.106:8000/disk1/Aasish/Nepal/State3/Chitwan/Bharatpur/Day1/Left/GH019130.MP4"
          .replaceAll(" ", "%20"),
      parse: true);

  VideoDimensions dimension = const VideoDimensions(1920, 1080);

  late PlayerController player = PlayerController(
    player: Player(id: media.resource.length, videoDimensions: dimension),
    duration: videoFile != null
        ? Duration(
            hours: videoFile!.info.duration.hour,
            minutes: videoFile!.info.duration.minute,
            seconds: videoFile!.info.duration.second,
            milliseconds: videoFile!.info.duration.millisecond,
          )
        : Duration.zero,
  );

  late VideoPlayerController controller = VideoPlayerController.network(
      videoFile != null ? videoFile!.foundPath : '')
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    }).catchError((e) {
      print(" $e text");
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    player.player.open(media, autoStart: false);

    // player.player.play();
    // if (UniversalPlatform.isDesktop) {}
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Expanded(
            flex: 14,
            child: Stack(
              children: [
                CustomVideoPlayer(
                    player: player.player, controller: controller),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      CustomOverlayEntry().showvideoBar(context, role);
                    },
                    child: Container(
                        width: 30.sw(),
                        height: 155.sh(),
                        color: const Color(0xffE4F5FF),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 73.sh(),
            color: primaryColor,
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
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomVideoPlayer extends StatelessWidget {
  CustomVideoPlayer({Key? key, required this.player, required this.controller})
      : super(key: key);
  final Player player;
  final VideoPlayerController controller;
  bool buffering = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UniversalPlatform.isDesktop
            ? Video(
                player: player,
                showControls: false,
              )
            : VideoPlayer(controller),
        if (buffering)
          Positioned.fill(
              child: Center(
                  child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )))
      ],
    );
  }
}

// class TestWidget extends StatelessWidget {
//   const TestWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//     );
//   }
// }

class SingleVideoPlayerControls extends HookConsumerWidget {
  const SingleVideoPlayerControls({this.web, this.desktop, Key? key})
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
              desktop!.player
                  .seek(((desktop!.duration)) - Duration(seconds: 10));
            } else {
              web!.seekTo((await (web!.position))! - Duration(seconds: 10));
            }
          },
          icon: Icon(
            Videomanager.rewind,
            color: Colors.white,
            size: 21.75.ssp(),
          ),
        ),
        SizedBox(
          width: 33.sw(),
        ),
        IconButton(
          onPressed: () {
            if (UniversalPlatform.isDesktop) {
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
              desktop!.player.setVolume(volume);

              ref.read(mutedProvider.state).state = false;
            } else if (volume == 0 && mute) {
              desktop!.player.setVolume(0);

              ref.read(mutedProvider.state).state = false;
              ref.read(volumeProvider.state).state = 0.2;
            } else {
              desktop!.player.setVolume(0);
              ref.read(mutedProvider.state).state = true;
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
                  size: 24.ssp(),
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
              desktop!.player.setVolume(val);

              if (volume != 0) {
                ref.read(mutedProvider.state).state = false;
              }
            }),
        SizedBox(
          width: 24.sw(),
        ),
        Text(
          '5:00 / 10:00',
          style: kTextStyleInterMedium.copyWith(
              fontSize: 14.ssp(),
              color: const Color(0xffeaeaea).withAlpha(180)),
        ),
      ],
    );
  }
}

class VideoTime extends StatelessWidget {
  const VideoTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
