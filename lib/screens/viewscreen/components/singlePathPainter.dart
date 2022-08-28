import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class SinglePathPainter extends CustomPainter {
  SinglePathPainter({required this.data, required this.transformer});
  final List<OriginalLocation> data;
  final MapTransformer transformer;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Paint duplicate = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    Path path = Path();

    var offsets = data
        .map((e) => transformer.fromLatLngToXYCoords(LatLng(e.lat, e.lng)))
        .toList();
    path.addPolygon(offsets, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
