import 'package:videomanager/screens/others/exporter.dart';

final shopServiceProvider = ChangeNotifierProvider<ShopService>((ref) {
  return ShopService._();
});

class ShopService extends ChangeNotifier {
  ShopService._() {
    load();
  }

  load() {}
}
