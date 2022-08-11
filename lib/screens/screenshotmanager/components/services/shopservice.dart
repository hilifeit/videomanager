import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';

final shopServiceProvider = ChangeNotifierProvider<ShopService>((ref) {
  return ShopService._();
});

class ShopService extends ChangeNotifier {
  ShopService._() {
    // load();
  }

  late final Shop shop;

  loadShop() {}
}
