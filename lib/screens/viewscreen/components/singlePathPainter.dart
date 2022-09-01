import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';

class Paths {
  Paths({required this.paths, required this.duplicate});
  Path paths;
  bool duplicate;
}

class SinglePathPainter extends CustomPainter {
  SinglePathPainter(
      {required this.data,
      required this.transformer,
      required this.paths,
      required this.getImage});
  final List<OriginalLocation> data;
  final MapTransformer transformer;
  final List<Paths> paths;
  final Function(ByteData) getImage;

  @override
  void paint(Canvas canvas, Size size) async {
    // TODO: implement paint
    final recorder = ui.PictureRecorder();
    final newCanvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(size.width, size.height)));
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Paint duplicate = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    //   var offsets = data
    //       .map((e) => transformer.fromLatLngToXYCoords(LatLng(e.lat, e.lng)))
    //       .toList();
    // path.addPolygon(offsets, false);
    // canvas.drawPath(paths.first.paths, paint);
    // canvas.drawPath(paths.first.paths, paint);

    var firstPoint = transformer
        .fromLatLngToXYCoords(LatLng(data.first.lat, data.first.lng));

    for (int i = 1; i < data.length; i++) {
      if (!data[i].duplicate) {
        canvas.drawLine(
            transformer
                .fromLatLngToXYCoords(LatLng(data[i - 1].lat, data[i - 1].lng)),
            transformer.fromLatLngToXYCoords(LatLng(data[i].lat, data[i].lng)),
            paint);
        newCanvas.drawLine(
            transformer
                .fromLatLngToXYCoords(LatLng(data[i - 1].lat, data[i - 1].lng)),
            transformer.fromLatLngToXYCoords(LatLng(data[i].lat, data[i].lng)),
            paint);
      } else {
        canvas.drawLine(
            transformer
                .fromLatLngToXYCoords(LatLng(data[i - 1].lat, data[i - 1].lng)),
            transformer.fromLatLngToXYCoords(LatLng(data[i].lat, data[i].lng)),
            duplicate);
        newCanvas.drawLine(
            transformer
                .fromLatLngToXYCoords(LatLng(data[i - 1].lat, data[i - 1].lng)),
            transformer.fromLatLngToXYCoords(LatLng(data[i].lat, data[i].lng)),
            duplicate);
      }
    }
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    var byte = await img.toByteData(format: ui.ImageByteFormat.png);
    getImage(byte!);
    // for (var element in paths) {
    //   if (!element.duplicate) {
    //     canvas.drawPath(element.paths, paint);
    //     print(element);
    //   }
    //   // else {
    //   //   canvas.drawPath(element.paths, duplicate);
    //   // }
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
