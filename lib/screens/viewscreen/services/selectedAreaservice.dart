import 'dart:collection';

import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
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
  late final selectedArea = Property<AreaModel?>(null, notifyListeners);
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

  selectArea(AreaModel area) {
    selectedHandle.value = null;
    _selectedPoints.clear();
    _selectedPoints
        .addAll(area.location.coordinates.map((e) => LatLng(e.last, e.first)));

    refinedSelection.value = [];
    path.value.reset();
    pathClosed.value = true;
    path.value
        .addPolygon(selectedPointsToOffset(transformer), pathClosed.value);
    refined.value = true;
    pathSelected.value = true;
    selectedArea.value = area;
    notifyListeners();
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
          refine();
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

  refine() {
    Future.delayed(const Duration(milliseconds: 20), () async {
      SelectedArea.transformer.controller.center = SelectedArea.transformer
          .fromXYCoordsToLatLng(path.value.getBounds().center);
      await Future.delayed(const Duration(milliseconds: 200), () async {
        bool perfect = smartRefine();
        while (perfect == false) {
          await Future.delayed(const Duration(milliseconds: 1), () {
            SelectedArea.transformer.controller.zoom =
                SelectedArea.transformer.controller.zoom - 0.2;
            perfect = smartRefine();
          });
        }
        if (currentSelection.value.isNotEmpty) {
          refinedSelection.value = currentSelection.value;
          refined.value = true;
        }
      });
    });
  }

  bool smartRefine() {
    Rect visibleScreen = Rect.fromLTWH(
        0,
        0,
        SelectedArea.transformer.constraints.maxWidth,
        SelectedArea.transformer.constraints.maxHeight - 5);

    Rect pathBoud = path.value.getBounds();
    if (visibleScreen.contains(pathBoud.topLeft) &&
        visibleScreen.contains(pathBoud.topRight) &&
        visibleScreen.contains(pathBoud.bottomLeft) &&
        visibleScreen.contains(pathBoud.bottomRight)) {
      return true;
    } else {
      return false;
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
