import 'package:videomanager/screens/others/exporter.dart';

final filterServiceProvider = ChangeNotifierProvider<FilterService>((ref) {
  return FilterService();
});

class FilterService extends ChangeNotifier {
  bool onlyNotUsable = false;
  bool? onlyPair = false;

  toggleUsable(bool value) {
    onlyNotUsable = value;
    notifyListeners();
  }

  togglePair(bool? value) {
    onlyPair = value;
    notifyListeners();
  }
}
