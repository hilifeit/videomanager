import 'package:videomanager/screens/dashboard/dashboard.dart';
import 'package:videomanager/screens/others/exporter.dart';

class UserStats extends StatelessWidget {
  UserStats({
    Key? key,
  }) : super(key: key);

  final List<CustomCard> items = [
    CustomCard(
        isvisible: false,
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Video Uploaded',
        color: const Color(0xffBADBEF),
        icon: Videomanager.videooutline),
    CustomCard(
        isvisible: false,
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Video Assigned',
        color: const Color(0xffBDD0FF),
        icon: Videomanager.add_user_svgrepo_com_1),
    CustomCard(
        isvisible: false,
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review issued',
        color: const Color(0xffC2BDFF),
        icon: Videomanager.refresh),
    CustomCard(
        isvisible: false,
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review Approved',
        color: const Color(0xffFFE1BD),
        icon: Videomanager.check),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 66.sw(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Statistics',
            style: kTextStyleInterSemiBold.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 21.ssp(),
            ),
          ),
          SizedBox(
            height: 60.sh(),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, index) {
                return SizedBox(
                  width: 29.sw(),
                );
              },
              itemBuilder: (_, index) {
                return items[index];
              },
            ),
          ),
          SizedBox(
            height: 56.sh(),
          ),
        ],
      ),
    );
  }
}
