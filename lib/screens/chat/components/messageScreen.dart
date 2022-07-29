import 'package:videomanager/screens/chat/components/messageBox.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/chat/models/messageTextField.dart';
import 'package:videomanager/screens/dashboard/component/filemodelsource.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.sw()),
      child: Column(
        children: [
          SizedBox(
            height: 60.sh(),
          ),
          Row(
            children: [
              ProfileAvatar(
                showDetails: true,
                profileradius: 30.sr(),
                nameFontSize: 20.ssp(),
              ),
              Spacer(),
              PopupMenuButton(itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {},
                    child: CustomPopUpMenuItemChild(text: 'View Profile'),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: CustomPopUpMenuItemChild(text: 'Mute Notification'),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: CustomPopUpMenuItemChild(text: 'Block User'),
                  )
                ];
                ;
              })
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomMessageBox(
                    message: "This is my message",
                    ownMessage: true,
                    messageTime:
                        (DateTime.now().subtract(Duration(days: 1, hours: 2))),
                  ),
                  SizedBox(
                    height: 20.sh(),
                  ),
                  CustomMessageBox(
                    message:
                        " aceholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.This is your message asds aa saas a a dasd a  das da dass  sds sd s dsds dss dsd s ds dsds d sds as ak nnks  nkn ks n nk nks nskn ksnkskk sksk knknk snsnksnks nk nk ns nksn",
                  ),
                  SizedBox(
                    height: 20.sh(),
                  ),
                  CustomMessageBox(
                    message: "हामीले कहिले गर्ने यस्तो? 😒😒😒😒😒",
                    ownMessage: true,
                  ),
                  SizedBox(
                    height: 20.sh(),
                  ),
                  CustomMessageBox(
                    message:
                        "हामीले कहिले गर्ने यस्तो? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.😒😒😒😒😒  aceholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.This is your message asds aa saas a a dasd a  das da dass  sds sd s dsds dss dsd s ds dsds d sds as ak nnks  nkn ks n nk nks nskn ksnkskk sksk knknk snsnksnks nk nk ns nksn",
                    ownMessage: true,
                  ),
                  CustomMessageBox(
                    message:
                        "Hello shruti dee 🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣",
                    ownMessage: true,
                  ),
                  SizedBox(
                    height: 20.sh(),
                  ),
                  SizedBox(
                    height: 20.sh(),
                  ),
                ],
              ),
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
                prefixIcon:
                    InkWell(onTap: () {}, child: Icon(Icons.emoji_emotions)),
                suffixIcon: InkWell(onTap: () {}, child: Icon(Icons.send)),
              )),
              // Expanded(
              //  child: InputTextField(
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
                width: 10.sw(),
              ),
              Icon(Icons.camera_alt_outlined),
              SizedBox(
                width: 10.sw(),
              ),
              Icon(Icons.mic)
            ],
          ),
          SizedBox(
            height: 40.sh(),
          )
        ],
      ),
    );
  }
}
