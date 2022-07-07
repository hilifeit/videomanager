import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';

class VideoPlayerControls extends ConsumerStatefulWidget {
  const VideoPlayerControls(
      {Key? key,
      this.leftWeb,
      this.rightWeb,
      this.leftDesktop,
      this.rightDesktop})
      : super(key: key);

  final VideoPlayerController? leftWeb, rightWeb;
  final PlayerController? leftDesktop, rightDesktop;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends ConsumerState<VideoPlayerControls>
    with TickerProviderStateMixin {
  late AnimationController _playPauseController;

  @override
  void initState() {
    super.initState();
    _playPauseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    // if (widget.leftDesktop!.current.media != null) {

    // print(widget.leftDesktop!.player.position.duration);
  }

  double maxSliderValue = 100;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 8,
            child: LayoutBuilder(builder: (context, constraint) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sw()),
                    child: Row(
                      children: [
                        iconButton(
                            icon: AnimatedIcons.play_pause,
                            leftWeb: widget.leftWeb,
                            rightWeb: widget.rightWeb,
                            leftDesktop: widget.leftDesktop?.player,
                            rightDesktop: widget.rightDesktop?.player),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child:
                          StatefulBuilder(builder: (context, setCustomState) {
                        late Duration length;
                        late Duration current;
                        if (UniversalPlatform.isDesktop) {
                          length = widget.leftDesktop!.duration;
                          current =
                              widget.leftDesktop!.player.position.position!;
                          widget.leftDesktop!.player.positionStream
                              .listen((event) {
                            setCustomState(() {
                              current = event.position!;
                              progress = mapDouble(
                                  x: event.position!.inMilliseconds.toDouble(),
                                  in_min: 0,
                                  in_max: double.parse(widget
                                      .leftDesktop!.duration.inMilliseconds
                                      .toString()),
                                  out_min: 0,
                                  out_max: maxSliderValue);
                            });
                          });
                        } else {
                          length = widget.leftWeb!.value.duration;
                          current = widget.leftWeb!.value.position;
                          widget.leftWeb!.addListener(() {
                            current = widget.leftWeb!.value.position;
                            setCustomState(() {
                              progress = mapDouble(
                                  x: widget
                                      .leftWeb!.value.position.inMilliseconds
                                      .toDouble(),
                                  in_min: 0,
                                  in_max: widget
                                      .leftWeb!.value.duration.inMilliseconds
                                      .toDouble(),
                                  out_min: 0,
                                  out_max: 100);
                            });
                          });
                        }
                        // print(progress);
                        return Row(
                          children: [
                            Text(
                              '${intToTime(current.inSeconds)} / ${intToTime(length.inSeconds)}',
                              style: kTextStyleInterMedium.copyWith(
                                  fontSize: 14.ssp(),
                                  color:
                                      const Color(0xffeaeaea).withAlpha(180)),
                            ),
                            Expanded(
                              child: Slider(
                                value: progress,
                                activeColor: const Color(0xffeaeaea),
                                inactiveColor: Colors.grey,
                                onChanged: (val) {
                                  Duration seekedPosition = Duration(
                                      milliseconds: mapDouble(
                                              x: val,
                                              in_min: 0,
                                              in_max: maxSliderValue,
                                              out_min: 0,
                                              out_max:
                                                  UniversalPlatform.isDesktop
                                                      ? widget
                                                          .leftDesktop!
                                                          .duration
                                                          .inMilliseconds
                                                          .toDouble()
                                                      : widget
                                                          .leftWeb!
                                                          .value
                                                          .duration
                                                          .inMilliseconds
                                                          .toDouble())
                                          .toInt());
                                  if (UniversalPlatform.isDesktop) {
                                    widget.leftDesktop!.player
                                        .seek(seekedPosition);
                                  } else {
                                    widget.leftWeb!.seekTo(seekedPosition);
                                  }

                                  setState(() {
                                    progress = (mapDouble(
                                        x: val,
                                        in_min: 0,
                                        in_max: maxSliderValue,
                                        out_min: 0,
                                        out_max: 1));
                                  });
                                  //    setState(() {
                                  //

                                  //   // mapDouble(progress, 0, 1, 0, widget.leftWeb.value.duration).toInt()

                                  // });
                                },
                                min: 0,
                                max: 100,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  // SizedBox(
                  //   height: 8.sh(),
                  // ),
                ],
              );
            }),
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget iconButton({
    required AnimatedIconData icon,
    VideoPlayerController? leftWeb,
    VideoPlayerController? rightWeb,
    Player? leftDesktop,
    Player? rightDesktop,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (UniversalPlatform.isDesktop) {
            if (leftDesktop!.playback.isPlaying &&
                rightDesktop!.playback.isPlaying) {
              leftDesktop.pause();
              rightDesktop.pause();

              _playPauseController.reverse();
            } else {
              leftDesktop.play();
              rightDesktop!.play();
              _playPauseController.forward();
            }
          } else {
            if (leftWeb!.value.isPlaying && rightWeb!.value.isPlaying) {
              leftWeb.pause();
              rightWeb.pause();
              _playPauseController.reverse();
            } else {
              leftWeb.play();
              rightWeb!.play();
              _playPauseController.forward();
            }
          }
        },
        child: AnimatedIcon(
          color: const Color(0xffeaeaea),
          icon: icon,
          progress: _playPauseController,
        ),
      ),
    );
  }
}
