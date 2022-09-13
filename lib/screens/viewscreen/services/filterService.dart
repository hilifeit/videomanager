import 'package:videomanager/screens/others/exporter.dart';

final filterServiceProvider = ChangeNotifierProvider<FilterService>((ref) {
  return FilterService();
});

class FilterService extends ChangeNotifier {
  bool onlyNotUsable = false;
  bool? onlyPair = false;
  bool state = false;
  List<bool> statesState = List.generate(7, (index) => false);
  toggleUsable(bool value) {
    onlyNotUsable = value;
    notifyListeners();
  }

  togglestate(bool value) {
    if (!value) {
      for (int i = 0; i < statesState.length; i++) {
        statesState[i] = false;
      }
    } else {
      if (!statesState.contains(true)) {
        statesState[0] = true;
      }
    }
    state = value;

    notifyListeners();
  }

  toggleStateSingle(bool value, int index) {
    statesState[index] = value;
    if (!state) state = true;

    if (!statesState.contains(true)) {
      state = false;
    }
    notifyListeners();
  }

  togglePair(bool? value) {
    onlyPair = value;
    notifyListeners();
  }
}
