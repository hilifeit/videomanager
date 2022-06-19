import 'package:videomanager/screens/others/exporter.dart';

List<CustomCard> items = [
  CustomCard(
      height: 139.sh(),
      width: 229.sw(),
      number: 15,
      text: 'Users',
      color: Color(0xffBADBEF),
      icon: Videomanager.usersoutline),
];

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.sw(), top: 74.sh()),
        child: Column(
          children: [
            Row(
              children: [
                CustomCard(
                  height: 139.sh(),
                  width: 229.sw(),
                  color: Color(0xffBADBEF),
                  icon: Videomanager.usersoutline,
                  number: 15,
                  text: 'Users',
                ),
                CustomCard(
                  height: 139.sh(),
                  width: 302.sw(),
                  color: Color(0xffBADBEF),
                  icon: Videomanager.videooutline,
                  number: 15,
                  text: 'Video Assigned',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    Key? key,
    required this.height,
    required this.width,
    required this.number,
    required this.text,
    required this.color,
    required this.icon,
    this.isvisible = true,
  }) : super(key: key);
  final double height;
  final double width;
  final int number;
  final String text;
  final Color color;
  final IconData icon;
  bool isvisible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.sr())),
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                number.toString(),
                style: kTextStyleInterMedium.copyWith(
                  fontSize: 37.ssp(min: 18),
                ),
              ),
              if (!isvisible)
                Icon(
                  icon,
                  color: Colors.black,
                  size: 24.sr(min: 14),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isvisible) ...[
                    Icon(
                      icon,
                      color: Colors.black,
                      size: 24.sr(),
                    ),
                    SizedBox(
                      width: 19.36.sw(),
                    ),
                  ],
                  Text(
                    text,
                    style: kTextStyleInterMedium.copyWith(
                        fontSize: 24.ssp(min: 14)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
