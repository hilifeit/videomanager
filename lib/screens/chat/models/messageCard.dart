import 'package:videomanager/screens/chat/components/profileAvatar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class UserMessageCard extends StatelessWidget {
  const UserMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sw()),
      // height: 50.sh(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(),
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
              Text('Message',
                  style:
                      kTextStyleIbmRegularBlack.copyWith(fontSize: 14.ssp())),
            ],
          ),
          Spacer(),
          Text(
            DateTime.now().toString().substring(0, 16),
            style: kTextStyleIbmRegular.copyWith(
                fontSize: 14.ssp(), color: lightBlack),
          ),
        ],
      ),
    );
  }
}
