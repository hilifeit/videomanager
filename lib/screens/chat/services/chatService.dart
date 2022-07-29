import 'dart:collection';

import 'package:videomanager/screens/others/exporter.dart';

final chatServiceChangeProvider = ChangeNotifierProvider<ChatServices>((ref) {
  return ChatServices();
});

class ChatServices extends ChangeNotifier {
  final List<int> _integer = [];

  UnmodifiableListView<int> get integer => UnmodifiableListView(_integer);

  add(int chihyaInthopa) {
    _integer.add(chihyaInthopa);
    notifyListeners();
  }

  remove(int thopa) {
    _integer.remove(thopa);
    notifyListeners();
    // _integer.removeAt(thopa);
  }

  clear(int consumeAll) {
    _integer.clear();
    notifyListeners();
  }
}
