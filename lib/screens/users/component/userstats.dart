import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/widgets/widgets.dart';

class UserStats extends StatelessWidget {
  UserStats({
    Key? key,
  }) : super(key: key);

  final List<CustomCardItem> items = [
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Video Uploaded',
        color: const Color(0xffBADBEF),
        icon: Videomanager.videooutline),
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Video Assigned',
        color: const Color(0xffBDD0FF),
        icon: Videomanager.add_user_svgrepo_com_1),
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review issued',
        color: const Color(0xffC2BDFF),
        icon: Videomanager.refresh),
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review Approved',
        color: const Color(0xffFFE1BD),
        icon: Videomanager.check),
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review Approved',
        color: const Color(0xffFFE1BD),
        icon: Videomanager.check),
    CustomCardItem(
        height: 139.sh(),
        width: 235.sw(),
        number: 15,
        text: 'Review Approved',
        color: const Color(0xffFFE1BD),
        icon: Videomanager.check),
  ];
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Scrollbar(
            thumbVisibility: true,
            controller: _controller,
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, index) {
                return SizedBox(
                  width: 29.sw(),
                );
              },
              itemBuilder: (_, index) {
                return CustomCard(item: items[index]);
              },
            ),
          ),
        ),
        SizedBox(
          height: 56.sh(),
        ),
      ],
    );
  }
}
