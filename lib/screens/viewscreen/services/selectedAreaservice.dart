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
  final int pointLimit = 4;
  addPoints(MapTransformer transformer, {required Offset point}) {
    if (selectedPoints.length < pointLimit) {
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

  Rect getRectFromPoints(MapTransformer transformer) {
    Path pointPath = Path();
    pointPath.addPolygon(selectedPointsOffset(transformer), true);
    return pointPath.getBounds();
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
      if (selectedHandle == i) {
        Paint SelectedHandle = Paint()..color = primaryColor.withOpacity(0.5);
        canvas.drawCircle(item, 16, SelectedHandle);
      }
      handlePath.addOval(Rect.fromCircle(center: item, radius: 12.sr()));
      handlePath.fillType = PathFillType.nonZero;

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
