import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';

class VideoPlayerControls extends ConsumerStatefulWidget {
  const VideoPlayerControls(
      {Key? key,
      this.leftWeb,
      this.rightWeb,
      this.leftDesktop,
      this.rightDesktop})
      : super(key: key);

  final VideoPlayerController? leftWeb, rightWeb;
  final Player? leftDesktop, rightDesktop;
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
  }

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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTapUp: (event) {
                        setState(() {
                          progress = (mapDouble(
                              x: event.localPosition.dx,
                              in_min: 0,
                              in_max: constraint.maxWidth,
                              out_min: 0,
                              out_max: 1));

                          // mapDouble(progress, 0, 1, 0, widget.leftWeb.value.duration).toInt()
                          if (UniversalPlatform.isDesktop) {
                          } else {
                            Duration seekedPosition = Duration(
                                milliseconds: mapDouble(
                                        x: progress,
                                        in_min: 0,
                                        in_max: 1,
                                        out_min: 0,
                                        out_max: widget.leftWeb!.value.duration
                                            .inMilliseconds
                                            .toDouble())
                                    .toInt());
                            widget.leftWeb!.seekTo(seekedPosition);
                          }
                        });
                      },
                      child:
                          StatefulBuilder(builder: (context, setCustomState) {
                        if (UniversalPlatform.isDesktop) {
                        } else {
                          widget.leftWeb!.addListener(() {
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
                                  out_max: 1);
                            });
                          });
                        }
                        return LinearProgressIndicator(
                          minHeight: 4.sh(),
                          color: Colors.white,
                          backgroundColor:
                              const Color(0xffeaeaea).withAlpha(150),
                          value: progress,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 8.sh(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sw()),
                    child: Row(
                      children: [
                        iconButton(
                            icon: AnimatedIcons.play_pause,
                            leftWeb: widget.leftWeb,
                            rightWeb: widget.rightWeb),
                        SizedBox(
                          width: 8.sw(),
                        ),
                        Text(
                          '5:07 / 15:28',
                          style: kTextStyleInterMedium.copyWith(
                              fontSize: 14.ssp(),
                              color: const Color(0xffeaeaea).withAlpha(180)),
                        )
                      ],
                    ),
                  ),
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

  Widget iconButton(
      {required AnimatedIconData icon,
      VideoPlayerController? leftWeb,
      VideoPlayerController? rightWeb}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (UniversalPlatform.isDesktop) {
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
