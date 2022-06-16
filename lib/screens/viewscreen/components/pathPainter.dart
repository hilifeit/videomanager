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
  bool debug = true;
  List<FileDetailMini> files;
  MapTransformer transformer;

  @override
  void paint(Canvas canvas, size) {
    var sampler = map(transformer.controller.zoom.toInt(), 7, 17, 1, 5);

    final selectedFile = ref.watch(selectedFileProvider);

    var paint = Paint()..style = PaintingStyle.fill;
    var rpaint = Paint()..style = PaintingStyle.fill;
    rpaint.style = PaintingStyle.fill;
    rpaint.color = Colors.red.withOpacity(0.01);

    paint.style = PaintingStyle.stroke;

    paint.strokeWidth = 3;

    var customCanvas = TouchyCanvas(context, canvas);
    Rect visibleScreen = Rect.fromLTWH(0, 0, transformer.constraints.maxWidth,
        transformer.constraints.maxHeight - 5);

    var visibleFiles = 0, totalDataUsedForPaint = 0;
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
          visibleFiles++;
          Path path = Path();
          Function tap, tapSecondary;
          tap = () {
            ref.read(selectedFileProvider.state).state = element;
          };
          tapSecondary = (TapUpDetails detail) {
            tap();
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    detail.globalPosition.dx,
                    detail.globalPosition.dy,
                    detail.globalPosition.dx + 1,
                    detail.globalPosition.dy + 1),
                items: [PopupMenuItem(child: Text('test'))]);
          };

          List<Offset> points = [];
          for (int i = 0; i < element.location.coordinates.length; i++) {
            Offset current = transformer.fromLatLngToXYCoords(LatLng(
                element.location.coordinates[i].last,
                element.location.coordinates[i].first));
            points.add(current);
          }
          totalDataUsedForPaint += points.length;
          paint.strokeWidth = 3;
          paint.style = PaintingStyle.stroke;
          paint.color = Colors.red;

          path.addPolygon(points, false);
          Paint newPaint = Paint()
            ..color = Theme.of(context).primaryColor.withOpacity(0.1);

          customCanvas.drawPath(path, paint, onTapUp: (details) {
            tap();
          }, onSecondaryTapUp: (detail) {
            tapSecondary(detail);
          });

          if (selectedFile != null) {
            if (selectedFile.id == element.id) {
              paint.strokeWidth = 6;
              paint.color = Theme.of(context).primaryColor;
              customCanvas.drawPath(path, paint, onTapUp: (details) {
                tap();
              }, onSecondaryTapUp: (detail) {});
              paint.color = Colors.red;
              paint.strokeWidth = 3;
              customCanvas.drawPath(path, paint, onTapUp: (details) {
                // tap();
              }, onSecondaryTapUp: (detail) {
                tapSecondary(detail);
              });

              newPaint.style = PaintingStyle.stroke;
              newPaint.color = Theme.of(context).primaryColor;
              customCanvas.drawRect(item, newPaint, onTapUp: ((details) {
                tap();
              }), onSecondaryTapUp: (detail) {
                tapSecondary(detail);
              });
              newPaint.style = PaintingStyle.fill;
              newPaint.color = Colors.transparent;
              customCanvas.drawRect(item, newPaint, onTapUp: ((details) {
                tap();
              }), onSecondaryTapUp: (detail) {
                tapSecondary(detail);
              });
            } else {
              customCanvas.drawRect(item, newPaint, onTapUp: ((details) {
                tap();
              }), onSecondaryTapUp: (detail) {
                tapSecondary(detail);
              });
            }
          } else {
            customCanvas.drawRect(path.getBounds(), newPaint,
                onTapUp: ((details) {
              tap();
            }), onSecondaryTapUp: (detail) {
              tapSecondary(detail);
            });
          }
          // path.close();
        }
      }
    }
    if (debug) {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, 40),
          paint
            ..color = Colors.white.withOpacity(0.8)
            ..style = PaintingStyle.fill);
      drawText(canvas,
          text:
              "Debug Window~     Files: ${files.length}    Visible: $visibleFiles    Visible Samples: $totalDataUsedForPaint",
          position: Offset(10, 10));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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

  drawText(canvas, {required String text, required Offset position}) {
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.red, fontSize: 16.ssp()), text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, position);
  }
}
