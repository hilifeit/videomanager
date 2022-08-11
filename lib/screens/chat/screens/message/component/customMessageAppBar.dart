import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomMessageBar extends StatelessWidget {
  const CustomMessageBar({Key? key, required this.header}) : super(key: key);
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
      Expanded(child: header),
    ]);
  }
}
