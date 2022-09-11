import 'package:flutter/gestures.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/components/screenshotscreen.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/snapModel.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';
import 'dart:ui' as ui;

import 'package:videomanager/screens/video/components/models/playerController.dart';

final mouseScrollProvider = StateProvider<double>((ref) {
  return 0.0;
});

class TimeLineCanvas extends ConsumerWidget {
  TimeLineCanvas({Key? key, required this.duration}) : super(key: key);
  final Duration duration;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollOffset = ref.watch(mouseScrollProvider.state).state;
    var snapService = ref.read(videoDataDetailServiceProvider);
    var snaps = ref.watch(videoDataDetailServiceProvider).snaps;
    snaps.sort((a, b) =>
        a.timeStamp.inMilliseconds.compareTo(b.timeStamp.inMilliseconds));

    return LayoutBuilder(builder: (context, constraint) {
      // print("constraints : ${constraint.maxHeight}");
      return Listener(
        onPointerSignal: (event) {
          // if (event is PointerScrollEvent) {
          var estimatedHeigh = snaps.length * SnapModel.height + 80.sh();

          // final delta = event.scrollDelta;
          // print(delta);
          // print(estimatedHeigh);
          // if (delta.dy > 0) {
          //   if (estimatedHeigh > constraint.maxHeight) {
          //     ref.read(mouseScrollProvider.state).state -= delta.dy;
          //   }
          // } else {
          //   if (ref.read(mouseScrollProvider.state).state < 0) {
          //     if (estimatedHeigh > constraint.maxHeight) {
          //       ref.read(mouseScrollProvider.state).state -= delta.dy;
          //     }
          //   }
          // }
          // print(ref.read(mouseScrollProvider.state).state);

          // if (estimatedHeigh > constraint.maxHeight ||
          //     scrollOffset.abs() < estimatedHeigh) {
          //   if (scrollOffset - delta.dy > 0 &&
          //       scrollOffset - delta.dy < estimatedHeigh)
          //     ref.read(mouseScrollProvider.state).state += delta.dy;
          //   else if (scrollOffset - delta.dy < estimatedHeigh &&
          //       scrollOffset - delta.dy != 0) {
          //     ref.read(mouseScrollProvider.state).state -= delta.dy;
          //   }
          // }
          // }
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              for (var snap in snaps)
                if (snap.image != null)
                  Builder(
                    builder: (context) {
                      var snapIndex = snaps.indexOf(snap);
                      Offset position = mapMilisecondIntoOffset(
                          index: snapIndex,
                          duration: duration,
                          maxWidth: constraint.maxWidth,
                          currentValue: snap.timeStamp,
                          scrollOffset: scrollOffset,
                          constraints: constraint);

                      // if (position.dy > constraint.maxHeight) {
                      //   var yPostion =
                      //   position = Offset(position.dx + 22.sw(), 80.sh());
                      // }

                      return Positioned(
                          left: position.dx,
                          top: position.dy,
                          child: GestureDetector(
                            onTap: () {
                              snapService.selectedSnap.value = snap;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ScreenShotScreen(
                                  edit: true,
                                );
                              }));
                            },
                            child: Stack(
                              children: [
                                Image.memory(
                                  snap.image!,
                                  width: 22.sw(),
                                  fit: BoxFit.fill,
                                ),
                                // Positioned(child: Text("10"))
                              ],
                            ),
                          ));
                    },
                  )

              // CanvasTouchDetector(
              //   builder: (context) {
              //     return CustomPaint(
              //       size: Size(constraint.maxWidth, constraint.maxHeight),
              //       painter: TimeLinePainter(
              //         context: context,
              //         ref: ref,
              //         duration: duration,
              //       ),
              //       // child: Container(
              //       //   color: Colors.red,
              //       // ),
              //     );
              //   },
              //   gesturesToOverride: const [
              //     GestureType.onTapUp,
              //     GestureType.onTapDown,
              //     GestureType.onSecondaryTapUp,
              //     // GestureType.onPanUpdate,
              //     // GestureType.onPanStart,
              //   ],
              // ),
              ,
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 20.sw(),
                  height: constraint.maxHeight,
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          left: 0,
                          top: 80.sh() - scrollOffset,
                          child: Container(
                              width: 15.sw(),
                              height: 15.sh(),
                              color: Theme.of(context).primaryColor),
                          duration: Duration(milliseconds: 100))
                    ],
                  ),
                  // child:
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Offset mapMilisecondIntoOffset(
      {required Duration duration,
      required double maxWidth,
      required Duration currentValue,
      required int index,
      required double scrollOffset,
      required BoxConstraints constraints}) {
    var xPosition = mapDouble(
        x: currentValue.inMilliseconds.toDouble(),
        in_min: 0,
        in_max: duration.inMilliseconds.toDouble(),
        out_min: 18.sw(),
        out_max: maxWidth);
    var yPosition = 80.sh();
    if (index != 0) yPosition += (SnapModel.height + 5.sh()) * index;
    // print(yPosition);

    yPosition = recurse(yPosition, constraints);

    return Offset(xPosition, yPosition + scrollOffset);
  }

  recurse(yPosition, constraints) {
    if (yPosition > constraints.maxHeight - 10.sh()) {
      double add = (yPosition - constraints.maxHeight) - 2.5.sh();

      yPosition = 80.sh() + add;
      if (yPosition < 80.sh()) {
        yPosition = 80.sh();
      }
    }
    if (yPosition > constraints.maxHeight - 10.sh()) {
      recurse(yPosition, constraints);
      return yPosition;
    } else {}
    return yPosition;
  }
}

// class TimeLinePainter extends CustomPainter {
//   TimeLinePainter(
//       {required this.duration, required this.ref, required this.context});
//   final Duration duration;
//   final WidgetRef ref;
//   final BuildContext context;

//   @override
//   void paint(Canvas canvas, Size size) async {
//     TouchyCanvas newCanvas = TouchyCanvas(context, canvas);
//     var snapService = ref.watch(videoDataDetailServiceProvider);
//     var snaps = ref.watch(videoDataDetailServiceProvider).snaps;

//     Paint imagePaint = Paint();
//     Paint badgePaint = Paint()..color = Colors.red;
//     Paint bgPaint = Paint()..color = Colors.white;

//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
//     snaps.sort((a, b) =>
//         a.timeStamp.inMilliseconds.compareTo(b.timeStamp.inMilliseconds));
//     for (var element in snaps) {
//       // if (element.shops.isNotEmpty)

//       if (element.shops.isNotEmpty) {
//         var snapIndex = snaps.indexOf(element);
//         Offset position = mapMilisecondIntoOffset(
//             index: snapIndex,
//             duration: duration,
//             maxWidth: size.width,
//             currentValue: element.timeStamp);
//         Path path = Path();
//         // RRect box = RRect.fromRectAndRadius(
//         //     Rect.fromLTWH(position.dx, position.dy, boxWidth, boxHeight),
//         //     const Radius.circular(2));
//         // path.addRRect(box);
//         if (element.decodedImage != null) {
//           var image = element.decodedImage!;
//           // ui.PictureRecorder recorder = ui.PictureRecorder();
//           // canvas.drawImageRect(element.decodedImage!, newRect,
//           //     Rect.fromLTWH(100, 100, 20, 16), imagePaint);
//           newCanvas.drawImage(image, position, imagePaint, onTapUp: (details) {
//             snapService.selectedSnap.value = element;
//             Navigator.push(context, MaterialPageRoute(builder: (_) {
//               return ScreenShotScreen(
//                 edit: true,
//               );
//             }));
//           });

//           path.addOval(Rect.fromCircle(
//               center: Offset(position.dx + image.width.toDouble(), position.dy),
//               radius: 8.sr()));
//           newCanvas.drawPath(path, badgePaint);

//           drawText(canvas,
//               text: element.shops.length.toString(),
//               position:
//                   Offset(position.dx + image.width.toDouble(), position.dy));
//         }

//         // canvas.drawPicture()
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }

//   Offset mapMilisecondIntoOffset(
//       {required Duration duration,
//       required double maxWidth,
//       required Duration currentValue,
//       required int index}) {
//     var xPosition = mapDouble(
//         x: currentValue.inMilliseconds.toDouble(),
//         in_min: 0,
//         in_max: duration.inMilliseconds.toDouble(),
//         out_min: 18.sw(),
//         out_max: maxWidth);
//     var yPosition = 80.sh();
//     if (index != 0) yPosition += (SnapModel.height + 5.sh()) * index;

//     return Offset(xPosition, yPosition);
//   }

//   drawText(canvas, {required String text, required Offset position}) {
//     TextSpan span = TextSpan(
//         style: TextStyle(color: Colors.white, fontSize: 9.ssp()), text: text);
//     TextPainter tp = TextPainter(
//         text: span,
//         textAlign: TextAlign.center,
//         textDirection: TextDirection.ltr);
//     tp.layout();

//     tp.paint(canvas,
//         Offset(position.dx - tp.width / 2, position.dy - tp.height / 1.8));
//   }
// }
