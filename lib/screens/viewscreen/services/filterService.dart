import 'package:videomanager/screens/others/exporter.dart';

final filterServiceProvider = ChangeNotifierProvider<FilterService>((ref) {
  return FilterService();
});

class Rider {
  Rider({required this.name, this.isSelected = false});
  String name;
  bool isSelected;
}

class FilterService extends ChangeNotifier {
  bool onlyNotUsable = false;
  bool? onlyPair = false;
  bool state = false, rider = false;
  List<Rider> riders = [];
  List<String> riderNames = [];
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

  toggleRider(bool value) {
    rider = value;

    for (int i = 0; i < riders.length; i++) {
      riders[i].isSelected = value;
      if (value) {
        riderNames.add(riders[i].name.toLowerCase());
      } else {
        riderNames.remove(riders[i].name.toLowerCase());
      }
    }
    notifyListeners();
  }

  toggleSingleRider(bool value, int index) {
    riders[index].isSelected = value;
    if (value) {
      riderNames.add(riders[index].name.toLowerCase());
    } else {
      riderNames.remove(riders[index].name.toLowerCase());
    }
    bool oneSelected = false;
    riders.forEach(((element) {
      if (element.isSelected) oneSelected = true;
    }));
    rider = oneSelected;
    notifyListeners();
  }

  addRider(List<String> rider) {
    if (rider.isNotEmpty) {
      riders.clear();

      riders.addAll(rider.map((e) => Rider(name: e)).toList());

      notifyListeners();
    }
  }
}
