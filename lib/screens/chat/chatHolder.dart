import 'package:videomanager/screens/chat/components/chatHome.dart';
import 'package:videomanager/screens/chat/components/messageScreen.dart';
import 'package:videomanager/screens/chat/components/profileInfoScreen.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ChatHolder extends StatelessWidget {
  const ChatHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ChatHome(),
          ),
          if (!ResponsiveLayout.isMobile) ...[
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              flex: ResponsiveLayout.isTablet ? 2 : 4,
              child: const MessageScreen(),
            ),
            const VerticalDivider(
              width: 0,
            ),
          ],
          if (ResponsiveLayout.isDesktop)
            const Expanded(flex: 1, child: ProfileInfoScreen())
        ],
      ),
    );
  }
}

