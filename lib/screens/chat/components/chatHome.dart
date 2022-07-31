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
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.ssp()),
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
                  final users = ref.watch(userChangeProvider).users;
                  return Scrollbar(
                    controller: scrollController,
                    child: ListView.separated(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return ProfileAvatar(
                            showDetails: false,
                            isActive: users[index].isActive,
                            name: users[index].name,
                          );
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
