import 'package:videomanager/screens/chat/components/messageScreen.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/chat/models/messageCard.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/viewscreen/components/customSearch.dart';

class ChatHome extends StatelessWidget {
  ChatHome({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(20.sw()),
        // color: secondaryColor,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.sh()),
          child: Row(
            children: [
              Text(
                'Chats',
                style: kTextStyleIbmMedium.copyWith(
                  fontSize: 14.ssp(),
                  color: Colors.black,
                ),
              ),
              Spacer(),
              if (ResponsiveLayout.isMobile)
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Videomanager.search,
                    color: lightBlack,
                    size: 14.ssp(),
                  ),
                ),
            ],
          ),
        ),
        if (!ResponsiveLayout.isMobile) ...[
          // SizedBox(
          //   height: 20.sh(),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sw()),
            child: Container(
              child: CustomSearch(),
              // color: darkGrey,
              height: 35.sh(),
            ),
          ),
        ],
        if (!ResponsiveLayout.isDesktop)
          Expanded(
            child: Consumer(builder: (context, ref, c) {
              final userProvider = ref.watch(userChangeProvider);
              final users = userProvider.users;
              users.sort(
                (b, a) =>
                    a.isActive.toString().compareTo(b.isActive.toString()),
              );
              return Scrollbar(
                // trackVisibility: ResponsiveLayout.isDesktop ? true : false,
                // thumbVisibility: ResponsiveLayout.isDesktop ? true : false,
                controller:
                    ResponsiveLayout.isDesktop ? scrollController : null,
                child: ListView.separated(
                    controller:
                        ResponsiveLayout.isDesktop ? scrollController : null,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      var widget = ProfileAvatar(
                        profileradius: 24,
                        isActive: users[index].isActive,
                        name: users[index].name,
                        onTap: () {
                          userProvider.selectedChatUser.value = users[index];
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return MessageScreen();
                          })));
                        },
                      );
                      if (index == 0)
                        return Row(
                          children: [
                            SizedBox(width: 10.sw()),
                            widget,
                          ],
                        );
                      if (index == users.length - 1)
                        return Row(
                          children: [
                            widget,
                            SizedBox(width: 5.sw()),
                          ],
                        );
                      return widget;
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        width: 10.sw(),
                      );
                    },
                    itemCount: users.length),
              );
            }),
          ),
        SizedBox(
          height: 20.sh(),
        ),
        Expanded(
          flex: 8,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                return UserMessageCard();
              }),
              separatorBuilder: ((context, index) => Divider(
                    thickness: 2,
                    height: 20.sh(),
                  )),
              itemCount: 5),
        ),
      ],
    ));
  }
}
