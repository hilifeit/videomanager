import 'dart:collection';

import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

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
  late final path = Property<Path>(Path(), () {});

  int pointLimit = 200;

  late final refinedSelection =
      Property<List<FileDetailMini>>([], notifyListeners);
  late final currentSelection = Property<List<FileDetailMini>>([], () {});

  late final refined = Property<bool>(false, notifyListeners);
  late final pathClosed = Property<bool>(false, notifyListeners);
  late final pathSelected = Property<bool>(false, notifyListeners);
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
      if (currentSelection.value.length != refinedSelection.value.length) {
        refined.value = false;
      }
      notifyListeners();
    }
  }

  Rect? getRectFromPoints() {
    if (selectedPoints.isEmpty || selectedPoints.length < 2) return null;

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
    // var sizeSampler = map(transformer.controller.zoom.toInt(), 10, 18, 1, 8);
    // sizeSampler = 9 - sizeSampler;
    var sizeSampler = 1;

    if (pathSelected.value) {
      sizeSampler = 1;
    } else {
      sizeSampler = 2;
    }
    for (int i = 0; i < points.length; i++) {
      var item = points[i];
      Path handlePath = Path();
      if (selectedHandle.value == i) {
        Paint selectedHandle = Paint()..color = primaryColor.withOpacity(0.5);
        canvas.drawCircle(item, (16 / sizeSampler).sr(), selectedHandle);
      }
      handlePath.addOval(
          Rect.fromCircle(center: item, radius: (12 / sizeSampler).sr()));
      handlePath.fillType = PathFillType.nonZero;

      // handlePath.addOval(Rect.fromCircle(center: item, radius: 20));
      handlePath.close();
      canvas.drawPath(handlePath, pointHandlePainter,
          // hitTestBehavior: HitTestBehavior.opaque,
          // onForcePressEnd: (detail) {
          //   print("here");
          // },
          onTapUp: ((details) {
        if (selectedPoints.length > 2 && !pathClosed.value && i == 0) {
          pathClosed.value = true;
          pathSelected.value = true;
        } else {
          selectedHandle.value = i;
          pathSelected.value = true;
        }
      }), onSecondaryTapUp: (details) {
        // pathSelected.value = false;
      });
      // selectedPath.addOval(Rect.fromCircle(center: item, radius: 7));
    }
    selectedPath.addPolygon(
      points,
      pathClosed.value,
    );
    path.value = selectedPath;
    canvas.drawPath(selectedPath, selectedPointPainter, onTapUp: (detail) {
      // print('here');

      // notifyListeners();
    }, hitTestBehavior: HitTestBehavior.translucent);

    canvas.drawPath(
        selectedPath,
        selectedPointPainter
          ..color = Colors.blue.withOpacity(0.025)
          ..style = PaintingStyle.fill, onTapUp: (detail) {
      print("here");
      pathSelected.value = true;

      // notifyListeners();
    }, hitTestBehavior: HitTestBehavior.translucent);
  }

  deSelectHandle() {
    if (selectedHandle.value != null) {
      selectedHandle.value = null;
    }
  }

  clear() {
    _selectedPoints.clear();
    pathClosed.value = false;
    refinedSelection.value = [];
    currentSelection.value = [];
    refined.value = false;
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
