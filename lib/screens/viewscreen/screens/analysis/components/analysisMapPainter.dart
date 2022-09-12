import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class AnalaysisMapPainter extends CustomPainter {
  AnalaysisMapPainter(
      {required this.files, required this.file, required this.transfromer});
  final List<FileDetailMini> files;
  final FileDetailMini file;
  final MapTransformer transfromer;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    Paint selectedPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;
    for (var element in files) {
      Path path = Path();
      List<LatLng> data = [];
      if (element.originalLocation.isEmpty) {
        data.addAll(element.location.coordinates
            .map((e) => LatLng(e.last, e.first))
            .toList());
      } else {
        data.addAll(
            element.originalLocation.map((e) => LatLng(e.lat, e.lng)).toList());
      }
      path.addPolygon(
          data
              .map((e) => transfromer
                  .fromLatLngToXYCoords(LatLng(e.latitude, e.longitude)))
              .toList(),
          false);
      canvas.drawPath(path, element != file ? paint : selectedPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
