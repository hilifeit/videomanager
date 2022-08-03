import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor, child: SafeArea(child: child));
  }
}
