import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/components/custominfo.dart';
import 'package:videomanager/screens/others/exporter.dart';

List<CustomCard> items = [
  CustomCard(
      height: 139.sh(),
      width: 229.sw(),
      number: 15,
      text: 'Users',
      color: const Color(0xffBADBEF),
      icon: Videomanager.usersoutline),
];

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TargetCard(),
            const UsersCard(),
            const AssignedVideoCard(),
          ],
        ),
        Row(
          children: [
            Container(
              height: 539.sh(),
              width: 593.sw(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.sr()),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 80.sw(), top: 9.sh()),
                    height: 42.sh(),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.sr()),
                          topRight: Radius.circular(8.sr())),
                    ),
                    child: Text(
                      'Assign Users',
                      style: kTextStyleIbmRegular.copyWith(
                        fontSize: 16.ssp(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Column(
                      children: [],
                    ),
                  ))
                ],
              ),
            ),
            const OutletCard(),
            Card(
              color: const Color(0xfffffdeb),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20.sh(),
                    left: 21.sw(),
                    right: 25.sw(),
                    bottom: 20.sh()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 42.sw(),
                            height: 42.sh(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                6.sr(),
                              ),
                              color: const Color(0xff696CFF).withOpacity(0.16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.sh(),
                                horizontal: 9.sw(),
                              ),
                              child: const Image(
                                  image: AssetImage(
                                      'assets/images/credit-card.png')),
                            )),
                        SizedBox(
                          height: 16.sh(),
                        ),
                        Text(
                          'Junk File',
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 15.ssp(), color: cardHeader),
                        ),
                        SizedBox(
                          height: 2.2.sh(),
                        ),
                        Text('200',
                            style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 22.ssp(),
                              color: const Color(0xff566a7f),
                            )),
                        SizedBox(
                          height: 8.8.sh(),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              size: 9.58.ssp(),
                            )
                          ],
                        )
                      ],
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class OutletCard extends StatelessWidget {
  const OutletCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffEFF9FF),
      child: Padding(
        padding: EdgeInsets.only(
            top: 14.sh(), left: 19.sw(), right: 18.93.sh(), bottom: 17.sh()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Outlet',
              style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 15.ssp(), color: cardHeader),
            ),
            SizedBox(
              height: 8.sh(),
            ),
            Text(
              '104',
              style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 26.ssp(), color: cardHeader),
            ),
            SizedBox(
              height: 5.sh(),
            ),
            Container(
              height: 22.sh(),
              width: 53.sw(),
              color: Theme.of(context).primaryColor.withOpacity(0.16),
              child: Center(
                child: Text(
                  '+34%',
                  style: kTextStyleIbmMedium.copyWith(
                      fontSize: 13.ssp(),
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: 18.sh(),
            ),
            Text(
              'Outlet Reach',
              style: kTextStyleIbmRegular.copyWith(
                  fontSize: 13.ssp(), color: const Color(0xffA1ACB8)),
            ),
            SizedBox(
              height: 3.sh(),
            ),
            Row(
              children: [
                SizedBox(
                  height: 8.sh(),
                  width: 89.sw(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(7.sr())),
                    child: const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      value: 0.5,
                      backgroundColor: Color(0xffECEEF1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 9.39.sw(),
                ),
                Text(
                  '50%',
                  style: kTextStyleIbmRegular.copyWith(
                    fontSize: 13.ssp(),
                    color: cardHeader,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AssignedVideoCard extends StatelessWidget {
  const AssignedVideoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffffdeb),
      child: Padding(
        padding: EdgeInsets.only(
            top: 20.sh(), left: 21.sw(), right: 25.sw(), bottom: 20.sh()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42.sw(),
                  height: 42.sh(),
                  color: const Color(0xffafafaf),
                ),
                SizedBox(
                  height: 16.sh(),
                ),
                Text(
                  'Videos Assigned',
                  style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 15.ssp(), color: cardHeader),
                ),
                SizedBox(
                  height: 2.2.sh(),
                ),
                Text(
                  '40 users',
                  style: TextStyle(
                    fontFamily: 'Ibm',
                    fontStyle: FontStyle.italic,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w100,
                    color: const Color(0xff566A7F),
                  ),
                ),
                SizedBox(
                  height: 13.08.sh(),
                ),
                Text(
                  'More video to be assigned',
                  style: kTextStyleIbmMedium.copyWith(
                      fontSize: 10.ssp(), color: const Color(0xffff3e1d)),
                ),
              ],
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffff0f0),
      child: Padding(
        padding: EdgeInsets.only(
            top: 20.sh(), left: 21.sw(), right: 25.81.sw(), bottom: 10.sh()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42.sw(),
                  height: 42.sh(),
                  color: const Color(0xffafafaf),
                ),
                SizedBox(
                  height: 16.sh(),
                ),
                Text(
                  'Users',
                  style: kTextStyleIbmSemiBold.copyWith(
                    fontSize: 15.ssp(),
                    color: cardHeader,
                  ),
                ),
                SizedBox(
                  height: 2.2.sh(),
                ),
                Text(
                  '104',
                  style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 22.ssp(), color: cardHeader),
                ),
                SizedBox(
                  height: 11.8.sh(),
                ),
                Container(
                  height: 24.75.sh(),
                  width: 99.sw(),
                  color: Colors.tealAccent,
                ),
              ],
            ),
            SizedBox(
              width: 17.69.sw(),
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}

class TargetCard extends StatelessWidget {
  const TargetCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffbfbfb),
      child: Padding(
        padding: EdgeInsets.only(
            top: 19.sh(), left: 24.sw(), bottom: 20.sh(), right: 35.79.sw()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 32.82.sw()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey Popular Koju!',
                    style: TextStyle(
                      fontFamily: 'Ibm',
                      fontStyle: FontStyle.italic,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w100,
                      color: const Color(0xffBABABA),
                    ),
                  ),
                  SizedBox(
                    height: 5.sh(),
                  ),
                  Text(
                    'Screenshot target this month',
                    style: kTextStyleIbmRegular.copyWith(
                        fontSize: 13.ssp(),
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 20.6.sh(),
                  ),
                  Text(
                    '100k',
                    style: kTextStyleIbmSemiBold.copyWith(
                        fontSize: 26.ssp(),
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '78% of target',
                    style: kTextStyleIbmRegular.copyWith(
                        fontSize: 13.ssp(), color: const Color(0xffA1ACB8)),
                  ),
                  SizedBox(
                    height: 10.sh(),
                  ),
                  SizedBox(
                    height: 30.sh(),
                    width: 130.sw(),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.zero),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => primaryColor)),
                      onPressed: () {
                       
                      },
                      child: Text(
                        'View Screenshot',
                        style: kTextStyleIbmRegular.copyWith(
                            fontSize: 13.ssp(), color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 96.51.sw(),
              height: 155.78.sh(),
              color: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
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
  final bool isvisible;

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
