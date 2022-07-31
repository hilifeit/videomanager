import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/users.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // message.test();

    return Container(
      padding: EdgeInsets.all(18.ssp()),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ProfileAvatar(
          //   profileradius: 30.sr(),
          //   showDetails: false,
          // ),
          // SizedBox(
          //   height: 20.sh(),
          // ),
          Text(
            'Users',
            style: kTextStyleIbmSemiBold.copyWith(
                fontSize: 16.ssp(), color: Colors.black),
          ),
          SizedBox(
            height: 15.sh(),
          ),
          Expanded(
            child: Consumer(
              builder: (_, ref, c) {
                final users = ref.watch(userChangeProvider).users;

                return ListView.separated(
                    itemBuilder: (_, index) {
                      return ProfileAvatar(
                        name: users[index].name,
                        showDetails: true,
                        isActive: users[index].isActive,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 10.sh(),
                      );
                    },
                    itemCount: users.length);
              },
            ),
          )
        ],
      ),
    );
  }
}
