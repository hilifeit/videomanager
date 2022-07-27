import 'package:videomanager/screens/chat/components/chatHome.dart';
import 'package:videomanager/screens/chat/components/messageScreen.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ChatHolder extends StatelessWidget {
  const ChatHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MessageScreen(),
        ),
        if (!ResponsiveLayout.isMobile)
          Expanded(
            flex: 4,
            child: MessageScreen(),
          ),
      ],
    );
  }
}
