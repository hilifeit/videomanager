import 'package:videomanager/screens/others/exporter.dart';

class CustomKeys {
  static final CustomKeys _instance = CustomKeys._internal();

  factory CustomKeys() => _instance;

  CustomKeys._internal();

  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  WidgetRef? ref;

  init(WidgetRef ref) {
    this.ref = ref;
  }
}
