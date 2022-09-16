import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final mapPointerServiceProvider =
    ChangeNotifierProvider<MapPointService>((ref) {
  return MapPointService._();
});

class MapPointService extends ChangeNotifier {
  MapPointService._();
  LatLng? _currentPoint;
  FileDetailMini? _file;
  String? _url;
  currentPoint(LatLng? point, FileDetailMini? file, {String? url}) {
    _currentPoint = point;
    _file = file;
    _url = url;
    notifyListeners();
  }

  FileDetailMini? get file => _file;
  String get url => _url ?? '';
  Offset? get point => _currentPoint != null && _file != null
      ? SelectedArea.transformer.fromLatLngToXYCoords(
          LatLng(_currentPoint!.latitude, _currentPoint!.longitude))
      : null;
}
