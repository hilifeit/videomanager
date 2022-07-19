import 'package:videomanager/screens/others/exporter.dart';

class CustomCardItem {
  CustomCardItem({
    this.height,
    this.width,
    required this.number,
    required this.text,
    required this.color,
    required this.icon,
  });

  double? height;
  double? width;
  final int number;
  final String text;
  final Color color;
  final IconData icon;
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.item}) : super(key: key);
  final CustomCardItem item;
  final color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: item.height ?? 128.sh(),
        // width: item.width ?? 183.sw(),
        child: Card(
      color: item.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            item.number.toString(),
            style: kTextStyleIbmMedium.copyWith(
                fontSize: ResponsiveLayout.isDesktop ? 37 : 24.ssp(min: 18),
                color: color),
          ),
          Icon(
            item.icon,
            color: color,
            size: 20.sr(
              min: 14,
            ),
          ),
          Text(
            item.text,
            style: kTextStyleIbmSemiBold.copyWith(
              fontSize: ResponsiveLayout.isDesktop ? 24.ssp() : 18.ssp(min: 14),
              color: color,
            ),
          ),
        ],
      ),
    ));
  }
}
