import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinecanvas.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinehead.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/videoplayer/singleplayervideocontroller.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';

final leftValueProvider = StateProvider<double>((ref) {
  return 0;
});

class TimeLineTop extends StatelessWidget {
  TimeLineTop({Key? key, required this.duration, this.desktop, this.web})
      : super(key: key);

  final Duration duration;
  final GlobalKey _timlineKey = GlobalKey();
  final double height = 58.sh();
  final double timelineThumbWidth = 14;
  final PlayerController? desktop;
  final VideoPlayerController? web;
  @override
  Widget build(BuildContext context) {
    final centerOfWidth = ((timelineThumbWidth.sw() / 2) + 10.sw() / 2);

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 58.sh(),
            color: const Color(0xffc6d9e5),
          ),
          Consumer(builder: (context, ref, c) {
            final zoom = ref.watch(timelineZoomProvider.state).state;

            int divison = mapDouble(
                    x: zoom, in_min: 0, in_max: 1, out_min: 10, out_max: 60)
                .round();

            //old code
            // double scrollHorizontal =
            //     ref.watch(horizontalDragProvider.state).state;

            //new code
            var scrollableWidth =
                (ref.read(constraintsProvider.state).state?.maxWidth ??
                        MediaQuery.of(context).size.width) -
                    ref.read(buttonWidthProvider.state).state;
            var displayWidth = divison * (duration.inSeconds / 60) * 50.sh();
            final double scrollHorizontal = (displayWidth / scrollableWidth) *
                ref.watch(horizontalDragProvider.state).state;
            //----------------------------

            return CustomPaint(
              size: Size(double.infinity, 50.sh()),
              painter: TestTimelineRuler(
                  scrollHorizontal: scrollHorizontal,
                  duration: duration,
                  height: 40.sh(),
                  subDivisor: divison.toInt()),
            );
          }),
          Consumer(builder: (context, ref, c) {
            if (UniversalPlatform.isDesktop) {
              int length = desktop!.duration.inMilliseconds;

              return StreamBuilder<PositionState>(
                  initialData: PositionState(),
                  stream: desktop!.player.positionStream,
                  builder: (context, snapshot) {
                    int position = snapshot.data!.position!.inMilliseconds;
                    var currentPosition = getCurrentPosition(
                        position, length, constraints, centerOfWidth);
                    return timelineHead(
                        centerOfWidth, currentPosition, ref, constraints);
                  });
            } else {
              int length = web!.value.duration.inMilliseconds;

              return ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: web!,
                  builder: (context, value, child) {
                    int position = value.position.inMilliseconds;
                    var currentPosition = getCurrentPosition(
                        position, length, constraints, centerOfWidth);
                    return timelineHead(
                        centerOfWidth, currentPosition, ref, constraints);
                  });
            }
          })
        ],
      );
    });
  }

  double getCurrentPosition(
      int position, int length, BoxConstraints constraints, centerOfWidth) {
    double result = 0;
    try {
      // print("$position $length ${constraints.maxWidth} $centerOfWidth");
      result = map(
              position,
              0,
              length,
              // -(timelineThumbWidth + centerOfWidth).toInt()
              0,
              (constraints.maxWidth - centerOfWidth - timelineThumbWidth)
                  .toInt())
          .toDouble();
    } catch (e, s) {
      print("$e $s");
    }
    return result;
  }

  AnimatedPositioned timelineHead(
      centerOfWidth, double left, WidgetRef ref, BoxConstraints constraints) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        left: centerOfWidth + left,
        top: height / 1.8,
        child: GestureDetector(
          onHorizontalDragUpdate: ((details) {
            // ref.read(leftValueProvider.state).state = mapDouble(
            //     x: details.globalPosition.dx - centerOfWidth,
            //     in_min: 0,
            //     in_max: constraints.maxWidth,
            //     out_min: 0,
            //     // timelineThumbWidth.sw() / 2 + 10.sw() / 2,
            //     out_max: constraints.maxWidth -
            //         centerOfWidth -
            //         timelineThumbWidth);
          }),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              TimelineHeadWidget(
                width: timelineThumbWidth,
                height: constraints.maxHeight - height / 1.8,
                key: _timlineKey,
              ),
              // Positioned(
              //     left: timelineThumbWidth / 2.2,
              //     top: 0,
              //     child: Container(
              //       color: Colors.grey,
              //       width: 1.5,

              //     ))
            ],
          ),
        ));
  }
}

// class TimeRulerPainter extends CustomPainter {
//   const TimeRulerPainter(
//       {required this.duration, required this.height, this.subDivisor = 9});
//   final Duration duration;
//   final double height;
//   final int subDivisor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     size = Size(size.width, size.height);
//     var paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;
//     var divisor = duration.inMilliseconds / 1000;

//     if (divisor > 60) divisor = (divisor / 60).ceilToDouble();
//     var widthDivisor = size.width / divisor;
//     for (int i = 0; i < divisor; i++) {
//       for (int j = 1; j < subDivisor; j++) {
//         // if (j != 0)
//         {
//           paint.color = Colors.black;

//           canvas.drawRect(
//               Rect.fromLTWH(
//                   (i * widthDivisor) + (j * (widthDivisor / subDivisor)),
//                   size.height / 2,
//                   1.sw(),
//                   4.sh()),
//               paint);
//         }
//       }
//       if (i != 0) {
//         paint.color = Colors.black;
//         TextSpan span = TextSpan(
//             style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Inter',
//                 color: Colors.black,
//                 fontSize: 14.ssp()),
//             text: '$i');
//         TextPainter tp = TextPainter(
//             text: span,
//             textAlign: TextAlign.center,
//             textDirection: TextDirection.ltr);
//         tp.layout();
//         tp.paint(
//             canvas,
//             Offset(i * widthDivisor - tp.size.width / 2,
//                 size.height / 2 - (tp.size.height / 2)));
//       }

//       // canvas.drawLine(Offset(i * widthDivisor, labelSeparator),
//       //     Offset(i * widthDivisor, labelSeparator + (size.height / 5)), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return true;
//   }
// }

class TestTimelineRuler extends CustomPainter {
  const TestTimelineRuler(
      {required this.scrollHorizontal,
      required this.duration,
      required this.height,
      this.subDivisor = 9});
  final Duration duration;
  final double height;
  final int subDivisor;
  final double scrollHorizontal;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    size = Size(size.width, size.height);
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    var divisor = duration.inMilliseconds / 1000;

    if (divisor > 60) divisor = (divisor / 60).ceilToDouble();

    var widthDivisor = (size.width / divisor);

    var numDivider = ((subDivisor) * (widthDivisor / 10));

    for (int i = 0; i < divisor; i++) {
      for (int j = 1; j < subDivisor; j++) {
        // if (j != 0)
        {
          paint.color = Colors.black;
          if (i == 0) {
            canvas.drawRect(
                Rect.fromLTWH(
                    (i * numDivider) +
                        (j * (widthDivisor / 10)) -
                        scrollHorizontal,
                    size.height / 2,
                    1.sw(),
                    4.sh()),
                paint);
          } else {
            canvas.drawRect(
                Rect.fromLTWH(
                    (i * numDivider) +
                        (j * (widthDivisor / 10)) -
                        scrollHorizontal,
                    size.height / 2,
                    1.sw(),
                    4.sh()),
                paint);
          }
        }
      }
      if (i != 0) {
        paint.color = Colors.black;
        TextSpan span = TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 14.ssp()),
            text: '$i');
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(
            canvas,
            Offset((numDivider * i - tp.size.width / 2) - scrollHorizontal,
                size.height / 2 - (tp.size.height / 2)));
      }

      // canvas.drawLine(Offset(i * widthDivisor, labelSeparator),
      //     Offset(i * widthDivisor, labelSeparator + (size.height / 5)), paint);
    }

    // for (int j = 1; j <= subDivisor; j++) {
    //   // if (j != 0)
    //   {
    //     paint.color = Colors.black;
    //     print((j * (widthDivisor / 10)));
    //     print(widthDivisor);
    //     canvas.drawRect(
    //         Rect.fromLTWH(
    //             (j * (widthDivisor / 10)), size.height / 2, 1.sw(), 4.sh()),
    //         paint);
    //   }
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
