import 'package:videomanager/screens/chat/components/chatHome.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({Key? key, this.profileradius = 20, this.isChatHome = true})
      : super(key: key);
  double profileradius;
  bool isChatHome;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: profileradius.sr(),
            backgroundColor: primaryColor,
          ),
          Positioned(
            right: -1,
            bottom: -2,
            child: CircleAvatar(
              radius: (profileradius.sr() * 0.4),
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 0.3 * profileradius.sr(),
                backgroundColor: successColor,
              ),
            ),
          ),
        ],
      ),
      if (!isChatHome) ...[
        SizedBox(
          width: 30.sw(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 14.ssp(), color: Colors.black),
            ),
            SizedBox(
              height: 5.sh(),
            ),
            Text('Online',
                style: kTextStyleIbmRegularBlack.copyWith(fontSize: 14.ssp())),
          ],
        )
      ],
    ]);
  }
}
