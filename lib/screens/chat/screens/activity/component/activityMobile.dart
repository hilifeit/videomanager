import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/chat/screens/message/messageScreen.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class ActivityMobile extends StatelessWidget {
  const ActivityMobile({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, ref, c) {
        final userProvider = ref.watch(userChangeProvider);
        final users = userProvider.users;
        users.sort(
          (b, a) => a.isActive.toString().compareTo(b.isActive.toString()),
        );
        return Scrollbar(
          // trackVisibility: ResponsiveLayout.isDesktop ? true : false,
          // thumbVisibility: ResponsiveLayout.isDesktop ? true : false,
          controller: ResponsiveLayout.isDesktop ? scrollController : null,
          child: ListView.separated(
              controller: ResponsiveLayout.isDesktop ? scrollController : null,
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
    );
  }
}
