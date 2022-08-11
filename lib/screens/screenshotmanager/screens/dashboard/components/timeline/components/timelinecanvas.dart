import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/components/screenshotscreen.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/snapModel.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';
import 'dart:ui' as ui;

class TimeLineCanvas extends ConsumerWidget {
  TimeLineCanvas({Key? key, required this.duration}) : super(key: key);
  final Duration duration;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: CanvasTouchDetector(
          builder: (context) {
            return CustomPaint(
              size: Size(constraint.maxWidth, constraint.maxHeight),
              painter: TimeLinePainter(
                context: context,
                ref: ref,
                duration: duration,
              ),
              // child: Container(
              //   color: Colors.red,
              // ),
            );
          },
          gesturesToOverride: const [
            GestureType.onTapUp,
            GestureType.onTapDown,
            GestureType.onSecondaryTapUp,
            // GestureType.onPanUpdate,
            // GestureType.onPanStart,
          ],
        ),
      );
    });
  }
}

class TimeLinePainter extends CustomPainter {
  TimeLinePainter(
      {required this.duration, required this.ref, required this.context});
  final Duration duration;
  final WidgetRef ref;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) async {
    TouchyCanvas newCanvas = TouchyCanvas(context, canvas);
    var snapService = ref.watch(videoDataDetailServiceProvider);
    var snaps = ref.watch(videoDataDetailServiceProvider).snaps;

    Paint imagePaint = Paint();
    Paint badgePaint = Paint()..color = Colors.red;
    Paint bgPaint = Paint()..color = Colors.white;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
    snaps.sort((a, b) =>
        a.timeStamp.inMilliseconds.compareTo(b.timeStamp.inMilliseconds));
    for (var element in snaps) {
      // if (element.shops.isNotEmpty)

      if (element.shops.isNotEmpty) {
        var snapIndex = snaps.indexOf(element);
        Offset position = mapMilisecondIntoOffset(
            index: snapIndex,
            duration: duration,
            maxWidth: size.width,
            currentValue: element.timeStamp);
        Path path = Path();
        // RRect box = RRect.fromRectAndRadius(
        //     Rect.fromLTWH(position.dx, position.dy, boxWidth, boxHeight),
        //     const Radius.circular(2));
        // path.addRRect(box);
        if (element.decodedImage != null) {
          var image = element.decodedImage!;
          // ui.PictureRecorder recorder = ui.PictureRecorder();
          // canvas.drawImageRect(element.decodedImage!, newRect,
          //     Rect.fromLTWH(100, 100, 20, 16), imagePaint);
          newCanvas.drawImage(image, position, imagePaint, onTapUp: (details) {
            snapService.selectedSnap.value = element;
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ScreenShotScreen(
                edit: true,
              );
            }));
          });

          path.addOval(Rect.fromCircle(
              center: Offset(position.dx + image.width.toDouble(), position.dy),
              radius: 8.sr()));
          newCanvas.drawPath(path, badgePaint);

          drawText(canvas,
              text: element.shops.length.toString(),
              position:
                  Offset(position.dx + image.width.toDouble(), position.dy));
        }

        // canvas.drawPicture()
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset mapMilisecondIntoOffset(
      {required Duration duration,
      required double maxWidth,
      required Duration currentValue,
      required int index}) {
    var xPosition = mapDouble(
        x: currentValue.inMilliseconds.toDouble(),
        in_min: 0,
        in_max: duration.inMilliseconds.toDouble(),
        out_min: 18.sw(),
        out_max: maxWidth);
    var yPosition = 80.sh();
    if (index != 0) yPosition += (SnapModel.height + 5.sh()) * index;

    return Offset(xPosition, yPosition);
  }

  drawText(canvas, {required String text, required Offset position}) {
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 9.ssp()), text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();

    tp.paint(canvas,
        Offset(position.dx - tp.width / 2, position.dy - tp.height / 1.8));
  }
}
