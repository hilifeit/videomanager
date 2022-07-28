import 'package:videomanager/screens/chat/components/messageBox.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/chat/models/messageTextField.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60.sh(),
        ),
        Row(
          children: [
            ProfileAvatar(
              isChatHome: false,
              profileradius: 30.sr(),
              nameFontSize: 20.ssp(),
            ),
            Spacer(),
            Icon(Icons.more_vert)
          ],
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: 50.sh(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sw()),
          child: Column(
            children: [
              CustomMessageBox(
                message: "This is my message",
                messageTime:
                    (DateTime.now().subtract(Duration(days: 1, hours: 2))),
              ),
              SizedBox(
                height: 20.sh(),
              ),
              CustomMessageBox(
                message:
                    "This is your message asds aa saas a a dasd a  das da dass  sds sd s dsds dss dsd s ds dsds d sds as ak nnks  nkn ks n nk nks nskn ksnkskk sksk knknk snsnksnks nk nk ns nksn",
                ownMessage: false,
              ),
              SizedBox(
                height: 20.sh(),
              ),
              CustomMessageBox(message: "हामीले कहिले गर्ने यस्तो? 😒😒😒😒😒"),
              SizedBox(
                height: 20.sh(),
              ),
            ],
          ),
        ),
        Spacer(),
        Divider(
          thickness: 2,
          height: 40.sh(),
        ),
        Row(
          children: [
            Expanded(
                child: MessageTextField(
              prefixIcon: Icon(Icons.emoji_emotions),
              suffixIcon: Icon(Icons.send),
            )),
            // Expanded(
            //   child: InputTextField(
            //     title: 'Message',
            //     isVisible: false,
            //     onChanged: (p0) {},
            //     prefixIcon:
            //         InkWell(onTap: () {}, child: Icon(Icons.emoji_emotions)),
            //     suffixIcon: InkWell(onTap: () {}, child: Icon(Icons.send)),
            //   ),
            // ),
            Icon(Icons.attach_file),
            SizedBox(
              width: 3.sw(),
            ),
            Icon(Icons.camera_alt_outlined),
            SizedBox(
              width: 3.sw(),
            ),
            Icon(Icons.mic)
          ],
        ),
        // ResponsiveLayout.isMobile
        //     ? Row(
        //         children: [
        //           Icon(Icons.emoji_emotions),
        //           TextFormField(),
        //           Icon(Icons.attachment),
        //           Icon(Icons.camera)
        //         ],
        //       )
        //     : Row(
        //         children: [
        //           Icon(Icons.text_format),
        //           TextFormField(),
        //           Icon(Icons.attachment),
        //         ],
        //       ),
        SizedBox(
          height: 40.sh(),
        )
      ],
    );
  }
}
