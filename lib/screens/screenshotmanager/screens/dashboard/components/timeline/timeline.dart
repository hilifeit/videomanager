import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinecanvas.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinetop.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';

class Timeline extends ConsumerWidget {
  Timeline(
      {Key? key,
      required this.size,
      required this.duration,
      this.desktop,
      this.web})
      : super(key: key);
  final heightChangeProvider = StateProvider<double>((ref) {
    return 203.sh();
  });
  final Size size;
  final Duration duration;
  final PlayerController? desktop;
  final VideoPlayerController? web;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customHeight = ref.watch(heightChangeProvider.state).state;
    final double defaultHeight = MediaQuery.of(context).size.height / 3;
    final double minHeight = 58.sh();
    return Positioned(
      left: 0,
      bottom: 0,
      width: size.width,
      height: customHeight,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                const SizedBox(
                  height: double.infinity,
                ),
                TimeLineCanvas(duration: duration),
                GestureDetector(
                    onDoubleTap: () {
                      if (customHeight == defaultHeight) {
                        ref.read(heightChangeProvider.state).state = minHeight;
                      } else if (customHeight == minHeight) {
                        ref.read(heightChangeProvider.state).state =
                            defaultHeight;
                      } else {
                        if (((defaultHeight - customHeight) <
                            (customHeight - minHeight))) {
                          ref.read(heightChangeProvider.state).state =
                              defaultHeight;
                        } else {
                          ref.read(heightChangeProvider.state).state =
                              minHeight;
                        }
                      }
                    },
                    child: TimeLineTop(
                      duration: duration,
                    )),
              ],
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  // ref.read(heightChangeProvider.state).state -=
                  //     details.delta.dy;

                  double h = customHeight - 2 * details.delta.dy;
                  if (h < minHeight) {
                    ref.read(heightChangeProvider.state).state = minHeight;
                  } else if (h > defaultHeight) {
                    ref.read(heightChangeProvider.state).state = defaultHeight;
                  } else {
                    ref.read(heightChangeProvider.state).state = h;
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: Container(
                    height: 10,
                    color: Colors.transparent,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
