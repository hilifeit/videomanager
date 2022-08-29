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

    List<Paths> paths = [];

    List<Offset> noDuplicatePath = [];

    List<Offset> duplicatePath = [];
    int count = 0;

    print(data.length);
    for (var element in data) {
      print(element.duplicate);
      if (!element.duplicate) {
        count++;
        var index = data.indexOf(element);

        if (index != 0) {
          if (data[index - 1].duplicate) {
            path.addPolygon(duplicatePath, true);
            paths.add(Paths(paths: path, duplicate: true));
            // count += duplicatePath.length;
            duplicatePath.clear();
          }
        }

        var offset =
            transformer.fromLatLngToXYCoords(LatLng(element.lat, element.lng));
        noDuplicatePath.add(offset);
      } else {
        count++;
        var index = data.indexOf(element);

        if (index != 0) {
          if (!data[index - 1].duplicate) {
            path.addPolygon(noDuplicatePath, false);
            paths.add(Paths(paths: path, duplicate: false));
            // count += noDuplicatePath.length;
            noDuplicatePath.clear();
          }
        }

        var offset =
            transformer.fromLatLngToXYCoords(LatLng(element.lat, element.lng));
        duplicatePath.add(offset);
      }
    }
    if (noDuplicatePath.isNotEmpty) {
      path.addPolygon(noDuplicatePath, false);
      paths.add(Paths(paths: path, duplicate: false));
      // count += noDuplicatePath.length;
    }
    if (duplicatePath.isNotEmpty) {
      path.addPolygon(duplicatePath, true);
      paths.add(Paths(paths: path, duplicate: true));
      // count += duplicatePath.length;
    }
    print("path : ${paths.length}");
    print(count);
    noDuplicatePath.clear();
    duplicatePath.clear();

    //   var offsets = data
    //       .map((e) => transformer.fromLatLngToXYCoords(LatLng(e.lat, e.lng)))
    //       .toList();
    // path.addPolygon(offsets, false);
    canvas.drawPath(paths.first.paths, paint);

    //   for (var element in paths) {
    //     if (!element.duplicate) {
    //       print(element.duplicate);
    //       canvas.drawPath(element.paths, paint);
    //     } else {
    //       canvas.drawPath(element.paths, duplicate);
    //     }
    //   }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
