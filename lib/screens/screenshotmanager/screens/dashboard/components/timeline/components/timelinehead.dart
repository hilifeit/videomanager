import 'package:videomanager/screens/others/exporter.dart';

class TimelineHeadWidget extends StatelessWidget {
  const TimelineHeadWidget(
      {Key? key, this.width = 14, this.height = 18, this.color})
      : super(key: key);

  final double width, height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    print(height);
    return SizedBox(
      width: width.sw(),
      height: height.sh(),
      child: CustomPaint(
        size: Size(double.infinity, height.sh()),
        painter: TimelineHeadPainter(
            color: color ?? Theme.of(context).primaryColor, height: 18.sh()),
      ),
    );
  }
}

class TimelineHeadPainter extends CustomPainter {
  TimelineHeadPainter({required this.color, required this.height});
  final Color color;
  final double height;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo(0, height * 0.6);
    path.lineTo(size.width * 0.4, height);
    path.lineTo(size.width * 0.65, height);
    path.lineTo(size.width, height * 0.6);
    path.lineTo(size.width, 0);

    // path0.lineTo(size.width * 0.4500000, size.height * 0.4800000);
    // path0.lineTo(size.width * 0.4625000, size.height * 0.4800000);
    // path0.lineTo(size.width * 0.4750000, size.height * 0.4400000);
    // path0.lineTo(size.width * 0.4750000, size.height * 0.4000000);
    // path0.lineTo(size.width * 0.4375000, size.height * 0.4000000);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawRect(Rect.fromLTWH((size.width / 2), 0, 2, size.height),
        paint..color = Colors.grey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
