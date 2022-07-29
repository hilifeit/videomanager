import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            height: 20,
            width: double.infinity,
          )
          // ProfileAvatar(
          //   profileradius: 30.sr(),
          //   showDetails: false,
          // ),
        ],
      ),
    );
  }
}
