import 'package:videomanager/screens/chat/components/messageBox.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProfileAvatar(
            isChatHome: false,
          ),
        ]),
        SizedBox(
          height: 50.sh(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sw()),
          child: Column(
            children: [
              CustomMessageBox(message: "This is my message"),
              SizedBox(
                height: 20.sh(),
              ),
              CustomMessageBox(
                message:
                    "This is your message asds aa saas a a dasd a  das da dass  sds sd s dsds dss dsd s ds dsds d sds as ak nnks  nkn ks n nk nks nskn ksnkskk sksk knknk snsnksnks nk nk ns nksn",
                ownMessage: false,
              ),
            ],
          ),
        )
      ],
    );
  }
}
