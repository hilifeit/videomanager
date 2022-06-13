import 'dart:math';
import 'package:videomanager/screens/others/exporter.dart';


class Painter extends CustomPainter {
  Painter({
    // required this.data,
    required this.currentIndex,
    required this.selectedIndex,
    required this.sample,
    required this.transformer,
  });
  // List<GeoFile> data;
  int currentIndex, selectedIndex;
  int sample;

  MapTransformer transformer;
  //final _random = Random();
  @override
  void paint(Canvas canvas, size) {
    var paint = Paint()..style = PaintingStyle.stroke;

    // var lPaint = Paint();

    // lPaint.strokeWidth = 1;

    paint.style = PaintingStyle.stroke;
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    Offset test =
        transformer.fromLatLngToXYCoords(LatLng(27.7251933, 85.3411312));
    Offset test1 =
        transformer.fromLatLngToXYCoords(LatLng(27.7351933, 85.3511312));
    Offset test2 =
        transformer.fromLatLngToXYCoords(LatLng(27.7351933, 85.3611312));
    // print(test);
    canvas.drawLine(test, test1, paint);
    canvas.drawLine(test1, test2, paint);
    // canvas.drawRect(
    //     Rect.fromLTWH(5, 5, transformer.constraints.maxWidth - 10,
    //         transformer.constraints.maxHeight - 10),
    //     paint);
    // for (int j = 0; j < data.length; j++) {
    //   paint.color = data[j].color;
    //   paint.strokeWidth = 3; //

    //   lPaint.color = data[j].color;
    //   // if (j == selectedIndex)
    //   {
    //     final offset = data[j]
    //         .geoData
    //         .map((e) => transformer.fromLatLngToXYCoords(LatLng(e.lat, e.lng)))
    //         .toList();
    //     // print(offset);
    //     // if (selectedIndex != j) {
    //     //   paint.color = data[j].color.withOpacity(0.3);
    //     //   paint.strokeWidth = 2.5;
    //     // } else {

    //     // }
    //     Path path = Path();
    //     path.moveTo(offset[0].dx, offset[0].dy);
    //     for (int i = 0; i < data[j].geoData.length; i += sample) {
    //       if (i < offset.length - sample) {
    //         if (i < currentIndex) {
    //           if (!data[j].geoData[i].duplicate) {
    //             paint.color = paint.color = Colors.blue;
    //             path.lineTo(offset[i].dx, offset[i].dy);
    //             canvas.drawLine(
    //               offset[i],
    //               offset[i + sample],
    //               paint,
    //             );
    //           } else {
    //             paint.color = paint.color = Colors.red;
    //             path.lineTo(offset[i].dx, offset[i].dy);
    //             canvas.drawLine(
    //               offset[i],
    //               offset[i + sample],
    //               paint,
    //             );
    //           }
    //         } else {
    //           if (data[j].isLine) {
    //             if (data[j].geoData[i].duplicate) {
    //               paint.color = Colors.red;
    //             } else {
    //               // paint.color = data[j].color;
    //               paint.color = Colors.grey;
    //             }
    //             path.lineTo(offset[i].dx, offset[i].dy);

    //             //  path.relativeLineTo(offset[i].dx, offset[i].dy);
    //             canvas.drawLine(
    //               offset[i],
    //               offset[i + sample],
    //               paint,
    //             );
    //           } else {
    //             paint.strokeWidth = 2;
    //             // path.lineTo(offset[i].dx, offset[i].dy);

    //             // canvas.drawPath(path, paint);

    //             canvas.drawCircle(offset[i], 1.5, paint);
    //           }
    //         }
    //       }
    //     }
    // print(path.);
    //canvas.drawPath(path, paint);
    //  canvas.drawPath(path, paint);
    // var rect = Rect.fromLTRB(
    //   transformer
    //       .fromLatLngToXYCoords(LatLng(data[j].boundingBox!.left, 0))
    //       .dx,
    //   transformer
    //       .fromLatLngToXYCoords(LatLng(data[j].boundingBox!.top, 0))
    //       .dx,
    //   transformer
    //       .fromLatLngToXYCoords(LatLng(data[j].boundingBox!.right, 0))
    //       .dx,
    //   transformer
    //       .fromLatLngToXYCoords(LatLng(data[j].boundingBox!.bottom, 0))
    //       .dx,
    // );
    // canvas.drawRect(rect, paint);
  }

  // Offset left = Offset(
  //     data[j].boundingBox!.topLeft.dx, data[j].boundingBox!.topLeft.dy);
  // canvas.drawCircle(, 2, paint);
  // canvas.drawLine(
  //     transformer.fromLatLngToXYCoords(LatLng(left.dx, left.dy)),
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.topRight.dx,
  //         data[j].boundingBox!.topRight.dy)),
  //     lPaint);
  // canvas.drawLine(
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.topRight.dx,
  //         data[j].boundingBox!.topRight.dy)),
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.bottomRight.dx,
  //         data[j].boundingBox!.bottomRight.dy)),
  //     lPaint);
  // canvas.drawLine(
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.topLeft.dx,
  //         data[j].boundingBox!.topLeft.dy)),
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.bottomLeft.dx,
  //         data[j].boundingBox!.bottomLeft.dy)),
  //     lPaint);
  // canvas.drawLine(
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.bottomLeft.dx,
  //         data[j].boundingBox!.bottomLeft.dy)),
  //     transformer.fromLatLngToXYCoords(LatLng(
  //         data[j].boundingBox!.bottomRight.dx,
  //         data[j].boundingBox!.bottomRight.dy)),
  //     lPaint);

  //canvas.drawRect(boundingBox(data), lPaint);

  //canvas..drawRect(a, lPaint);

  // canvas.drawCircle(centroid(data), 5, lPaint);

  // paint.color = Colors.blue;
  // paint.strokeWidth = 6;
  // canvas.drawCircle(data[currentIndex], 10, paint);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Rect boundingBoxOffset(List<Offset> list) {
    double minX = double.infinity;
    double maxX = 0;
    double minY = double.infinity;
    double maxY = 0;
    for (int i = 0; i < list.length; i++) {
      minX = min(minX, list[i].dx);
      minY = min(minY, list[i].dy);
      maxX = max(maxX, list[i].dx);
      maxY = max(maxY, list[i].dy);
    }

    //var space = 5;
    var rec = Rect.fromLTWH(minX, minY, (maxX - minX), (maxY - minY));

    //print(rec);
    return rec;
  }

  double indicativeAngle(List<Offset> points) {
    Offset c = centroid(points);
    return atan2(c.dy - points[0].dy, c.dx - points[0].dx);
  }

  Offset centroid(List<Offset> points) {
    double x = 0;
    double y = 0;
    for (int i = 0; i < points.length; i++) {
      x += points[i].dx;
      y += points[i].dy;
    }
    x = x / points.length;
    y = y / points.length;

    return Offset(x, y);
  }
}
