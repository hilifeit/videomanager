import 'dart:typed_data';

import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/snapModel.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final videoDataDetailServiceProvider =
    ChangeNotifierProvider<VideoDataDetail>((ref) {
  return VideoDataDetail._();
});

class VideoDataDetail extends ChangeNotifier {
  VideoDataDetail._();
  final List<SnapModel> _snaps = [];
  List<SnapModel> get snaps => _snaps;
  late final selectedSnap = Property<SnapModel?>(null, notifyListeners);
  clear() {
    _snaps.clear();
    notifyListeners();
  }

  bool checkAndAddSnap(Duration duration, {Uint8List? imageData}) {
    var snap = SnapModel(shops: [], timeStamp: duration, image: imageData);

    var matches = _snaps.where((element) => element.timeStamp == duration);
    if (matches.isEmpty) {
      _snaps.add(snap);
      selectedSnap.value = snap;
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  notify() {
    notifyListeners();
  }

  addShop(Shop shop) {
    if (selectedSnap.value != null) {
      selectedSnap.value!.shops.add(shop);
      notifyListeners();
    }
  }

  clearShop() {
    if (selectedSnap.value != null) {
      selectedSnap.value!.shops.clear();
      notifyListeners();
    }
  }

  cancelNewSnap() {
    if (selectedSnap.value != null) {
      _snaps.remove(selectedSnap.value);
      selectedSnap.value = null;
    }
  }

  removeShop(Shop shop) {
    if (selectedSnap.value != null) {
      selectedSnap.value!.shops.remove(shop);
      notifyListeners();
    }
  }

  deselectSnap() {
    selectedSnap.value = null;
  }
}
