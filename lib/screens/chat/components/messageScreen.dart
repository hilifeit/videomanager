import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ProfileAvatar(
        isChatHome: false,
        
      ),
    ]);
  }
}
