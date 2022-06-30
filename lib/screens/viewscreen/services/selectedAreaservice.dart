import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';

final selectedAreaProvider = ChangeNotifierProvider<SelectedArea>((ref) {
  return SelectedArea._();
});

class SelectedArea extends ChangeNotifier {
  SelectedArea._();

  List<LatLng> selectedPoints = [];

  List<Offset> selectedPointsOffset(MapTransformer transformer) =>
      selectedPoints.map((e) => transformer.fromLatLngToXYCoords(e)).toList();
  int? selectedHandle;
  addPoints(MapTransformer transformer, {required Offset point}) {
    if (selectedPoints.length < 6) {
      selectedPoints.add(transformer.fromXYCoordsToLatLng(point));
      notifyListeners();
    }
  }

  moveHandle(MapTransformer transformer, {required Offset newPosition}) {
    if (selectedHandle != null) {
      selectedPoints[selectedHandle!] =
          transformer.fromXYCoordsToLatLng(newPosition);
      notifyListeners();
    }
  }

  draw(TouchyCanvas canvas, MapTransformer transformer) {
    Paint selectedPointPainter = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    Paint pointHandlePainter = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    List<Offset> points = selectedPointsOffset(transformer);
    Path selectedPath = Path();

    for (int i = 0; i < points.length; i++) {
      var item = points[i];
      Path handlePath = Path();
      // if (selectedHandle == i) {
      //   handlePath.addOval(Rect.fromCircle(center: item, radius: 3));
      // }
      handlePath.addRect(Rect.fromCenter(center: item, width: 20, height: 20));
      // handlePath.addOval(Rect.fromCircle(center: item, radius: 20));
      handlePath.close();
      canvas.drawPath(handlePath, pointHandlePainter,
          // hitTestBehavior: HitTestBehavior.opaque,
          // onForcePressEnd: (detail) {
          //   print("here");
          // },
          onTapUp: ((details) {
        selectedHandle = i;

        notifyListeners();
      }));
      // selectedPath.addOval(Rect.fromCircle(center: item, radius: 7));
    }
    selectedPath.addPolygon(points, true);

    canvas.drawPath(selectedPath, selectedPointPainter);
  }

  deSelectHandle() {
    if (selectedHandle != null) {
      selectedHandle = null;
      notifyListeners();
    }
  }

  clear() {
    selectedPoints.clear();
    notifyListeners();
  }
}
