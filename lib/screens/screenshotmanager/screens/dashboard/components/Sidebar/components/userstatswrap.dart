import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/widgets/widgets.dart';

class UserStatsWrap extends StatelessWidget {
  UserStatsWrap({
    Key? key,
  }) : super(key: key);

  final List<CustomCardItem> cardItems = [
    CustomCardItem(
        number: 15,
        text: 'Screenshot',
        color: const Color(0xffBADBEF),
        icon: Videomanager.image_icon),
    CustomCardItem(
        number: 15,
        text: 'Video Assigned',
        color: const Color(0xffBDD0FF),
        icon: Videomanager.videooutline),
    CustomCardItem(
        number: 15,
        text: 'Complete',
        color: const Color(0xffC2BDFF),
        icon: Icons.done_all_rounded),
    CustomCardItem(
        number: 15,
        text: 'Pending',
        color: const Color(0xffFFE1BD),
        icon: Videomanager.clipboard),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: ResponsiveLayout.isDesktop ? 46.sw() : 13.sw(),
      mainAxisSpacing: ResponsiveLayout.isDesktop ? 37.sh() : 10.sh(),
      childAspectRatio: 1.5,
      crossAxisCount: ResponsiveLayout.isTablet ? 4 : 2,
      children: List.generate(
        cardItems.length,
        (index) => CustomCard(
          item: cardItems[index],
        ),
      ),
    );

    // Wrap(
    //   spacing: 46.sw(),
    //   runSpacing: 15.sh(),
    //   children:

    // );
  }
}
