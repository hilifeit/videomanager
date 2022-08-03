import 'package:videomanager/screens/chat/components/customMessageBar.dart';
import 'package:videomanager/screens/chat/components/messageBox.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/chat/components/typingWidget.dart';
import 'package:videomanager/screens/chat/components/viewProfile.dart';
import 'package:videomanager/screens/chat/models/messageTextField.dart';
import 'package:videomanager/screens/chat/services/chatService.dart';
import 'package:videomanager/screens/dashboard/component/filemodelsource.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.read(userChangeProvider);
    final selectedUser = ref.watch(userChangeProvider).selectedChatUser.value;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            if (ResponsiveLayout.isMobile && selectedUser != null)
              Expanded(
                  flex: 1,
                  child: CustomMessageBar(header: header(selectedUser, ref))),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveLayout.isDesktop ? 50.sw() : 20.sw()),
                child: selectedUser == null
                    ? const Center(
                        child: Text("Select a user to start conversation"),
                      )
                    : Column(
                        children: [
                          if (ResponsiveLayout.isDesktop) ...[
                            SizedBox(
                              height: 60.sh(),
                            ),
                            header(selectedUser, ref),
                            SizedBox(
                              height: 15.sh(),
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                          ],

                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 30.sw()),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    // clipBehavior: Clip.none,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50.sh(),
                                        ),
                                        SizedBox(
                                          height: 20.sh(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Consumer(
                                    builder: (_, ref, c) {
                                      final isTyping = ref
                                          .watch(userChangeProvider)
                                          .isTyping
                                          .value;
                                      return isTyping
                                          ? Align(
                                              alignment: Alignment.bottomLeft,
                                              child: TypingWidget())
                                          : Container();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Spacer(),

                          if (ResponsiveLayout.isDesktop)
                            Divider(
                              thickness: 2,
                              height: 40.sh(),
                            ),
                          Row(
                            children: [
                              Expanded(
                                  child: MessageTextField(
                                onChanged: (value) {
                                  customSocket.socket.emit("typing",
                                      {"to": selectedUser.id, "data": value});
                                },
                                onSend: (value) {
                                  customSocket.socket.emit("message",
                                      {"to": selectedUser.id, "data": value});
                                },
                                prefixIcon: InkWell(
                                    onTap: () {
                                      ref
                                          .read(chatServiceChangeProvider)
                                          .add(10);
                                    },
                                    child: Icon(Icons.emoji_emotions)),
                                suffixIcon: InkWell(
                                    onTap: () {}, child: Icon(Icons.send)),
                              )),
                              // GestureDetector(
                              //     onTap: () {}, child: Icon(Icons.attach_file)),
                              // SizedBox(
                              //   width: 10.sw(),
                              // ),
                              // Icon(Icons.camera_alt_outlined),
                              // SizedBox(
                              //   width: 10.sw(),
                              // ),
                              // Icon(Icons.mic)
                            ],
                          ),

                          SizedBox(
                            height:
                                ResponsiveLayout.isDesktop ? 40.sh() : 20.sh(),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(UserModelMini selectedUser, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileAvatar(
          showDetails: true,
          profileradius: 30.sr(),
          nameFontSize: 20.ssp(),
          name: selectedUser.name,
          isActive: selectedUser.isActive,
        ),
        const Spacer(),
        PopupMenuButton(
            tooltip: '',
            offset: Offset(50, 50),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () async {
                    var user = await ref
                        .read(userChangeProvider)
                        .fetchOneUser(selectedUser.id);
                    if (ResponsiveLayout.isMobile) {
                      Future.delayed(const Duration(milliseconds: 5), () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewProfile(
                                  isActive: selectedUser.isActive, user: user);
                            },
                          ),
                        );
                      });
                    } else {
                      Future.delayed(const Duration(milliseconds: 5), () async {
                        return showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: SizedBox(
                                  width: 520.sw(),
                                  child: ViewProfile(
                                    user: user,
                                    isActive: selectedUser.isActive,
                                  ),
                                ),
                              );
                            }));
                      });
                    }
                  },
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
            })
      ],
    );
  }
}
