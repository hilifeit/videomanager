import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class Paths {
  Paths({required this.paths, required this.duplicate});
  Path paths;
  bool duplicate;
}

class SinglePathPainter extends CustomPainter {
  SinglePathPainter(
      {required this.data, required this.transformer, required this.paths});
  final List<OriginalLocation> data;
  final MapTransformer transformer;
  final List<Paths> paths;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

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
      } else {
        canvas.drawLine(
            transformer
                .fromLatLngToXYCoords(LatLng(data[i - 1].lat, data[i - 1].lng)),
            transformer.fromLatLngToXYCoords(LatLng(data[i].lat, data[i].lng)),
            duplicate);
      }
    }

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
