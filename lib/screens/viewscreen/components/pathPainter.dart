import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class Painter extends CustomPainter {
  Painter(this.context, this.ref,
      {required this.files,
      required this.transformer,
      required this.selectedFileProvider});
  // List<GeoFile> data;
  // int currentIndex, selectedIndex;
  // int sample;
  final BuildContext context;
  final WidgetRef ref;
  final StateProvider<FileDetailMini?> selectedFileProvider;
  List<FileDetailMini> files;
  MapTransformer transformer;
  //final _random = Random();
  @override
  void paint(Canvas canvas, size) {
    var sampler = map(transformer.controller.zoom.toInt(), 7, 17, 1, 5);

    final selectedFile = ref.watch(selectedFileProvider);

    var paint = Paint()..style = PaintingStyle.fill;
    var rpaint = Paint()..style = PaintingStyle.fill;
    rpaint.style = PaintingStyle.fill;
    rpaint.color = Colors.red.withOpacity(0.01);
    // lPaint.strokeWidth = 1;

    paint.style = PaintingStyle.stroke;

    paint.strokeWidth = 3;

    var customCanvas = TouchyCanvas(context, canvas);
    Rect visibleScreen = Rect.fromLTWH(0, 0, transformer.constraints.maxWidth,
        transformer.constraints.maxHeight - 5);
    Rect test = Rect.fromLTWH(100, 100, 100, 100);
    canvas.drawRect(test, paint);
    // canvas.drawRect(visibleScreen, paint);
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
          // customCanvas.drawRect(
          //   item,
          //   rpaint,
          //   onTapUp: (details) {
          //     ref.read(selectedFileProvider.state).state = element;
          //   },
          //   onSecondaryTapUp: (detail) {
          //     print(detail.localPosition);
          //     // showMenu(
          //     //     context: context,
          //     //     position:
          //     //         RelativeRect.fromLTRB(detail.localPosition.dx, 0, 0, 0),
          //     //     items: [PopupMenuItem(child: Text("tets"))]);
          //   },
          // );
          // canvas.drawRect(item, paint);
          Path path = Path();

          Offset start = transformer.fromLatLngToXYCoords(LatLng(
              element.location.coordinates.first[1],
              element.location.coordinates.first[0]));

          // path.moveTo(start.dx, start.dy);
          // print(sampler);
          List<Offset> points = [];
          for (int i = 0; i < element.location.coordinates.length; i++) {
            Offset current = transformer.fromLatLngToXYCoords(LatLng(
                element.location.coordinates[i].last,
                element.location.coordinates[i].first));
            points.add(current);
            // path.lineTo(current.dx, current.dy);
            // path.transform(Matrix4.fromFloat64List(_m4storage));
          }
          bool shouldDraw = true;
          // for (int i = 0; i < points.length; i++) {
          //   if (i != 0 && i < points.length - 1) {
          //     var distance = (points[i - 1] - points[i]).distance;
          //     if (distance > 200) shouldDraw = false;
          //   }
          // }
          // var a = canvas.drawPoints(PointMode.polygon, points, paint);

          paint.strokeWidth = 3;
          paint.style = PaintingStyle.stroke;
          paint.color = Colors.red;
          if (shouldDraw) {
            path.addPolygon(points, false);
            Paint newPaint = Paint()
              ..color = Theme.of(context).primaryColor.withOpacity(0.1);
            customCanvas.drawRect(path.getBounds(), newPaint,
                onTapUp: ((details) {
              ref.read(selectedFileProvider.state).state = element;
            }));
          }

          // var newpath = path.shift(Offset(1, 1));
          // var newpath1 = path.shift(Offset(-1, -1));
          // customCanvas.drawPath(newpath, paint, onTapUp: (details) {
          //   ref.read(selectedFileProvider.state).state = element;
          // });
          // customCanvas.drawPath(newpath1, paint, onTapUp: (detail) {
          //   ref.read(selectedFileProvider.state).state = element;
          // });
          // path.transform(Float64List.fromList(
          //     [100, 0, 0, 0, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]));
          customCanvas.drawPath(path, paint, onTapUp: (details) {
            ref.read(selectedFileProvider.state).state = element;
          }, onSecondaryTapUp: (detail) {});
          if (selectedFile != null) {
            if (selectedFile.id == element.id) {
              paint.strokeWidth = 6;
              paint.color = Theme.of(context).primaryColor;
              customCanvas.drawPath(path, paint, onTapUp: (details) {
                ref.read(selectedFileProvider.state).state = element;
              }, onSecondaryTapUp: (detail) {});
              paint.color = Colors.red;
              paint.strokeWidth = 3;
              customCanvas.drawPath(path, paint, onTapUp: (details) {
                // ref.read(selectedFileProvider.state).state = element;
              }, onSecondaryTapUp: (detail) {});
            }
          }
          // path.close();
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  // @override
  // bool hitTest(Offset position) {
  //   // print(position);
  //   // return true;
  // }

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
