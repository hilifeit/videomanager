import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class DottedBox extends StatelessWidget {
  const DottedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CustomPaint(
        size: Size(100, 100),
        painter: DottedBoxPainter(),
      ),
    );
  }
}

class DottedBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    Rect rectangle = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rectangle, paint);

    canvas.drawLine(Offset(0, 0), Offset(1920, 1080), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
