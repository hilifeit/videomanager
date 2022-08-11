import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/components/timelinehead.dart';

final leftValueProvider = StateProvider<double>((ref) {
  return 0;
});

class TimeLineTop extends StatelessWidget {
  TimeLineTop({Key? key, required this.duration}) : super(key: key);

  final Duration duration;
  final GlobalKey _timlineKey = GlobalKey();
  final double height = 58.sh();
  final double timelineThumbWidth = 14;

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
          CustomPaint(
            size: Size(double.infinity, 50.sh()),
            painter: TimeRulerPainter(duration: duration, height: 40.sh()),
          ),
          Consumer(builder: (context, ref, c) {
            final left = ref.watch(leftValueProvider.state).state;

            return Positioned(
                left: centerOfWidth + left,
                top: height / 1.8,
                child: GestureDetector(
                  onHorizontalDragUpdate: ((details) {
                    ref.read(leftValueProvider.state).state = mapDouble(
                        x: details.globalPosition.dx - centerOfWidth,
                        in_min: 0,
                        in_max: constraints.maxWidth,
                        out_min: 0,
                        // timelineThumbWidth.sw() / 2 + 10.sw() / 2,
                        out_max: constraints.maxWidth -
                            centerOfWidth -
                            timelineThumbWidth);
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
          })
        ],
      );
    });
  }
}

class TimeRulerPainter extends CustomPainter {
  const TimeRulerPainter(
      {required this.duration, required this.height, this.subDivisor = 9});
  final Duration duration;
  final double height;
  final int subDivisor;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    size = Size(size.width, size.height);
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    var divisor = duration.inMilliseconds / 1000;

    if (divisor > 60) divisor = (divisor / 60).ceilToDouble();
    var widthDivisor = size.width / divisor;
    for (int i = 0; i < divisor; i++) {
      for (int j = 1; j < subDivisor; j++) {
        // if (j != 0)
        {
          paint.color = Colors.black;

          canvas.drawRect(
              Rect.fromLTWH(
                  (i * widthDivisor) + (j * (widthDivisor / subDivisor)),
                  size.height / 2,
                  1.sw(),
                  4.sh()),
              paint);
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
            Offset(i * widthDivisor - tp.size.width / 2,
                size.height / 2 - (tp.size.height / 2)));
      }

      // canvas.drawLine(Offset(i * widthDivisor, labelSeparator),
      //     Offset(i * widthDivisor, labelSeparator + (size.height / 5)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
