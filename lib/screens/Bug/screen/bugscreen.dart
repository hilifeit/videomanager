import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';

class BugScreen extends StatelessWidget {
  const BugScreen({Key? key, required this.isActive, required this.user})
      : super(key: key);
  final bool isActive;
  final UserModelMini user;
  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveLayout.isMobile ? 16.ssp() : 21.ssp();
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (ResponsiveLayout.isMobile)
            AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
            ),
          SizedBox(
            height: 24.sh(),
          ),
          Align(
            alignment: Alignment.center,
            child: ProfileAvatar(
              name: user.name,
              isActive: isActive,
              profileradius: 60.sr(),
            ),
          ),
          SizedBox(
            height: 45.sh(),
          ),
          Row(
            children: [
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name:',
                    style: kTextStyleIbmRegular.copyWith(fontSize: fontSize),
                  ),
                  SizedBox(
                    height: 24.sh(),
                  ),
                  Text(
                    'Username:',
                    style: kTextStyleIbmRegular.copyWith(fontSize: fontSize),
                  ),
                  SizedBox(
                    height: 24.sh(),
                  ),
                  Text(
                    'Role:',
                    style: kTextStyleIbmRegular.copyWith(fontSize: fontSize),
                  ),
                     SizedBox(
                    height: 24.sh(),
                  ),             
                  Text(
                    'Bug Details:',
                    style: kTextStyleIbmRegular.copyWith(fontSize: fontSize),
                  ),
             
                  
                ],
              ),
              SizedBox(
                width: 30.sw(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 2,
                    style:
                        kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  ),
                  SizedBox(
                    height: 24.sh(),
                  ),
                  // Text(
                  //   user.username,
                  //   style:
                  //       kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  // ),
                  // SizedBox(
                  //   height: 24.sh(),
                  // ),
                  // Text(
                  //   user.email,
                  //   style:
                  //       kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  // ),
                  // SizedBox(
                  //   height: 24.sh(),
                  // ),
                  // Text(
                  //   user.mobile.toString(),
                  //   style:
                  //       kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  // ),
                  SizedBox(
                    height: 24.sh(),
                  ),
                  Text(
                    user.createdAt.toString().substring(0, 10),
                    style:
                        kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  ),
                  SizedBox(
                    height: 24.sh(),
                  ),
                  Text(
                    getRole(user.role),
                    style:
                        kTextStyleIbmRegularBlack.copyWith(fontSize: fontSize),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 24.sh(),
          ),
        ],
      ),
    );
  }
}

// appBar: ResponsiveLayout.isMobile
//           ? AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               foregroundColor: Theme.of(context).primaryColor,
//             )
//           : null,
