import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/model/settings.dart';
import 'package:videomanager/screens/settings/screens/locationsettings/models/locationsetting.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/screens/usersettings/models/usersetting.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';

final Setting setting = Setting(
  mapSetting: MapSetting(
      zoom: 1,
      stroke: 3,
      scroll: 40,
      sample: Sample(miniMap: 50, original: 100, view: 50),
      defaultLocation: DefaultLocation(enabled: false, lat: 1.0, lng: 1.0),
      filterCount: 1),
  userSetting: UserSetting(videoPerUser: 120),
  videoSetting: VideoSetting(
      videoQuality: 1,
      allowMinMapFScreen: true,
      videoFScreen: true,
      videourl: 'http://192.168.16.106:8000'),
  locationSetting: LocationSetting(starvaFile: true),
);
final defaultSettingProvider = StateProvider<Setting>((ref) {
  return setting;
});
final settingChangeNotifierProvider =
    ChangeNotifierProvider<SettingService>((ref) {
  // SettingService service = SettingService();
  return SettingService(setting);
});

const String settingStorageKey = "Settings";

class SettingService extends ChangeNotifier {
  SettingService(this._masterSetting) {
    load();
  }
  Setting _masterSetting;

  Setting get setting => _masterSetting;

  store() async {
    await storage.write(settingStorageKey, _masterSetting.toJson());
  }

  load() async {
    var storedData = storage.read(settingStorageKey);
    // print(storedData);
    if (storedData == null) {
      setdefaultSetting();
    } else {
      _masterSetting = Setting.fromJson(storedData);
      notifyListeners();
    }
  }

  setdefaultSetting() {
    _masterSetting = setting;
    store();
    notifyListeners();
  }

  updateSetting({
    MapSetting? mapSetting,
    VideoSetting? videoSetting,
    UserSetting? userSetting,
    LocationSetting? locationSetting,
  }) {
    _masterSetting = _masterSetting.copyWith(
      mapSetting: mapSetting ?? _masterSetting.mapSetting,
      videoSetting: videoSetting ?? _masterSetting.videoSetting,
      userSetting: userSetting ?? _masterSetting.userSetting,
      locationSetting: locationSetting ?? _masterSetting.locationSetting,
    );

    store();
    notifyListeners();
  }
}
