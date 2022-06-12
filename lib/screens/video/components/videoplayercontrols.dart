import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/constant.dart';

class VideoPlayerControls extends ConsumerStatefulWidget {
  VideoPlayerControls({required this.left, required this.right});

  final VideoPlayerController left, right;
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

                          // mapDouble(progress, 0, 1, 0, widget.left.value.duration).toInt()
                          Duration seekedPosition = Duration(
                              milliseconds: mapDouble(
                                      x: progress,
                                      in_min: 0,
                                      in_max: 1,
                                      out_min: 0,
                                      out_max: widget
                                          .left.value.duration.inMilliseconds
                                          .toDouble())
                                  .toInt());
                          widget.left.seekTo(seekedPosition);
                        });
                      },
                      child:
                          StatefulBuilder(builder: (context, setCustomState) {
                        widget.left.addListener(() {
                          setCustomState(() {
                            progress = mapDouble(
                                x: widget.left.value.position.inMilliseconds
                                    .toDouble(),
                                in_min: 0,
                                in_max: widget
                                    .left.value.duration.inMilliseconds
                                    .toDouble(),
                                out_min: 0,
                                out_max: 1);
                          });
                        });
                        return LinearProgressIndicator(
                          minHeight: 4.h,
                          color: Colors.white,
                          backgroundColor: Color(0xffeaeaea).withAlpha(150),
                          value: progress,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        iconButton(
                            icon: AnimatedIcons.play_pause,
                            left: widget.left,
                            right: widget.right),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          '5:07 / 15:28',
                          style: kTextStyleInterMedium.copyWith(
                              fontSize: 14.sp,
                              color: Color(0xffeaeaea).withAlpha(180)),
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
      required VideoPlayerController left,
      required VideoPlayerController right}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (left.value.isPlaying && right.value.isPlaying) {
            left.pause();
            right.pause();
            _playPauseController.reverse();
          } else {
            left.play();
            right.play();
            _playPauseController.forward();
          }
        },
        child: AnimatedIcon(
          color: Color(0xffeaeaea),
          icon: icon,
          progress: _playPauseController,
        ),
      ),
    );
  }
}
