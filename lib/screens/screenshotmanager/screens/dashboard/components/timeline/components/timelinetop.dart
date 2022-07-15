import 'package:videomanager/screens/others/exporter.dart';

class TimeLineTop extends StatelessWidget {
  const TimeLineTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = 58.sh();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sw()),
      height: height,
      color: const Color(0xffc6d9e5),
      alignment: Alignment.centerLeft,
      child: CustomPaint(
        size: Size(double.infinity, 15.sh()),
        painter: TimelineTopPainter(),
      ),
    );
  }
}

class TimelineTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;
    Path path = Path();
    for (int j = 0; j < 10; j++) {
      for (int i = 0; i < 9; i++) {
        canvas.drawRect(
            Rect.fromLTWH(((i * 10) + j * 100).sw(), 0, 2.sw(), 10.sh()),
            paint);
      }
      // TextSpan span = TextSpan(
      //     style: TextStyle(color: Colors.black, fontSize: 12.ssp()),
      //     text: (j + 1).toString());
      // TextPainter tp = TextPainter(
      //     text: span,
      //     textAlign: TextAlign.center,
      //     textDirection: TextDirection.ltr);
      // tp.layout();
      // tp.paint(canvas, Offset((j + 90), 0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
