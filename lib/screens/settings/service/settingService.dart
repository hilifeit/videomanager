import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/model/settings.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting.dart';

final settingChangeNotifierProvider =
    ChangeNotifierProvider<SettingService>((ref) {
  return SettingService();
});

const String settingStorageKey = "Settings";

class SettingService extends ChangeNotifier {
  SettingService() {
    load();
  }
  Setting? _masterSetting;

  Setting? get setting => _masterSetting;

  store() {
    if (_masterSetting != null) {
      storage.write(settingStorageKey, _masterSetting!.toJson());
    }
  }

  load() {
    var storedData = storage.read(settingStorageKey);
    if (storedData == null) {
      setdefaultSetting();
    } else {
      _masterSetting = Setting.fromJson(storedData);
      notifyListeners();
    }
  }

  setdefaultSetting() {
    _masterSetting = Setting(
        mapSetting: MapSetting(
            zoom: 1.0,
            stroke: 1,
            scroll: 1.0,
            sample: Sample(miniMap: 1, original: 1, view: 1),
            defaultLocation:
                DefaultLocation(enabled: false, lat: 1.0, lng: 1.0),
            filterCount: 1));
    store();
    notifyListeners();
  }

  // updateSetting(Setting setting) {
  //   masterSetting!.copyWith(mapSetting: setting.mapSetting);
  //   notifyListeners();
  // }
}
