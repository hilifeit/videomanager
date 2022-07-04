import 'dart:collection';

import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';

final selectedAreaServiceProvider = ChangeNotifierProvider<SelectedArea>((ref) {
  return SelectedArea._();
});

class SelectedArea extends ChangeNotifier {
  SelectedArea._();

  final List<LatLng> _selectedPoints = [];
  List<LatLng> get selectedPoints => UnmodifiableListView(_selectedPoints);
  List<Offset> selectedPointsToOffset(MapTransformer transformer) =>
      UnmodifiableListView(_selectedPoints
          .map((e) => transformer.fromLatLngToXYCoords(e))
          .toList());

  late final selectedHandle = Property<int?>(null, notifyListeners);

  final int pointLimit = 4;

  static late MapTransformer transformer;

  addPoints({required Offset point}) {
    if (_selectedPoints.length < pointLimit) {
      _selectedPoints.add(transformer.fromXYCoordsToLatLng(point));
      notifyListeners();
    }
  }

  moveHandle({required Offset newPosition}) {
    if (selectedHandle.value != null) {
      _selectedPoints[selectedHandle.value!] =
          transformer.fromXYCoordsToLatLng(newPosition);
      notifyListeners();
    }
  }

  Rect? getRectFromPoints() {
    if (selectedPoints.isEmpty || selectedPoints.length < 3) return null;

    Path pointPath = Path();
    pointPath.addPolygon(selectedPointsToOffset(transformer), true);
    return pointPath.getBounds();
  }

  draw(TouchyCanvas canvas) {
    Paint selectedPointPainter = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    Paint pointHandlePainter = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    List<Offset> points = selectedPointsToOffset(transformer);
    Path selectedPath = Path();

    for (int i = 0; i < points.length; i++) {
      var item = points[i];
      Path handlePath = Path();
      if (selectedHandle.value == i) {
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
        selectedHandle.value = i;
      }));
      // selectedPath.addOval(Rect.fromCircle(center: item, radius: 7));
    }
    selectedPath.addPolygon(points, true);

    canvas.drawPath(selectedPath, selectedPointPainter);
  }

  deSelectHandle() {
    if (selectedHandle.value != null) {
      selectedHandle.value = null;
    }
  }

  clear() {
    _selectedPoints.clear();
    notifyListeners();
  }
}

class Property<T> {
  Property(T initialValue, this.notifyListeners) {
    _value = initialValue;
  }

  late T _value;
  final void Function() notifyListeners;

  T get value => _value;

  set value(T value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}
