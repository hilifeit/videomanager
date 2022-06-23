import 'package:videomanager/screens/others/exporter.dart';

final filterServiceProvider = ChangeNotifierProvider<FilterService>((ref) {
  return FilterService();
});

class FilterService extends ChangeNotifier {
  bool onlyNotUsable = false;

  toggleUsable(bool value) {
    onlyNotUsable = value;
    notifyListeners();
  }
}
