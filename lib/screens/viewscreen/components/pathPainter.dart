import 'dart:math';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class Painter extends CustomPainter {
  Painter(
    this.context, {
    required this.files,
    required this.transformer,
  });
  // List<GeoFile> data;
  // int currentIndex, selectedIndex;
  // int sample;
  final BuildContext context;
  List<FileDetailMini> files;
  MapTransformer transformer;
  //final _random = Random();
  @override
  void paint(Canvas canvas, size) {
    var paint = Paint()..style = PaintingStyle.stroke;
    var rpaint = Paint()..style = PaintingStyle.fill;
    rpaint.style = PaintingStyle.fill;
    rpaint.color = Colors.transparent;
    // lPaint.strokeWidth = 1;

    paint.style = PaintingStyle.stroke;
    paint.color = Colors.red;
    paint.strokeWidth = 3;

    var customCanvas = TouchyCanvas(context, canvas);
    Rect visibleScreen = Rect.fromLTWH(
        50,
        50,
        transformer.constraints.maxWidth - 50,
        transformer.constraints.maxHeight - 50);

    for (var element in files) {
      // if (files.indexOf(element) == 10)
      {
        Offset topLeft = transformer.fromLatLngToXYCoords(LatLng(
            element.boundingBox!.topLeft.dx, element.boundingBox!.topLeft.dy));
        Offset topRight = transformer.fromLatLngToXYCoords(LatLng(
            element.boundingBox!.topRight.dx,
            element.boundingBox!.topRight.dy));
        Offset bottomLeft = transformer.fromLatLngToXYCoords(LatLng(
            element.boundingBox!.bottomLeft.dx,
            element.boundingBox!.bottomLeft.dy));

        var height = (topLeft - topRight).distance;
        var width = (topLeft - bottomLeft).distance;

        Rect item = Rect.fromCenter(
            center: transformer.fromLatLngToXYCoords(LatLng(
                element.boundingBox!.center.dx,
                element.boundingBox!.center.dy)),
            width: width,
            height: height);

        if (item.overlaps(visibleScreen)) {
          customCanvas.drawRect(item, rpaint, onTapUp: (details) {
            print(element.id);
          });

          Path path = Path();

          Offset start = transformer.fromLatLngToXYCoords(LatLng(
              element.location.coordinates.first[1],
              element.location.coordinates.first[0]));

          path.moveTo(start.dx, start.dy);
          for (var elementLocation in element.location.coordinates) {
            Offset current = transformer.fromLatLngToXYCoords(
                LatLng(elementLocation.last, elementLocation.first));
            path.lineTo(current.dx, current.dy);
          }
          // path.close();
          customCanvas.drawPath(path, paint, onTapUp: (details) {
            print(element.id);
          }, onSecondaryTapUp: (detail) {
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(25, 25, 0, 0),
                items: [PopupMenuItem(child: Text("tets"))]);
          });
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
