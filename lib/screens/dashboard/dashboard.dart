import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/components/videoscreenshot/videoscreenshot.dart';
import 'package:videomanager/screens/dashboard/table.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/widgets/widgets.dart';

List<CustomCardItem> items = [
  CustomCardItem(
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
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(flex: 2, child: TargetCard()),
              Expanded(child: UsersCard()),
              Expanded(child: AssignedVideoCard()),
              Expanded(child: VideoScreenshot(value: 10)),
              Expanded(
                child: ScreenShotReview(),
              ),
              Expanded(
                flex: 2,
                child: CustomTable(),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              AssignManager(video: 14),
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
                                color:
                                    const Color(0xff696CFF).withOpacity(0.16),
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
        ),
      ]),
    );
  }
}

class ScreenShotReview extends StatelessWidget {
  const ScreenShotReview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xffF4FCFF),
        child: Padding(
          padding: EdgeInsets.only(
              top: 14.sh(), left: 19.sw(), right: 25.sh(), bottom: 15.sh()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Screenshot\nReview',
                style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 15.ssp(),
                  color: const Color(0xff697A8D),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.sw()),
                child: SizedBox(
                    height: 118.sr(),
                    width: 118.sr(),
                    child: Stack(
                      children: [
                        const Image(
                            image: AssetImage('assets/images/Oval.png')),
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '72%',
                              style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 22.ssp(),
                                color: const Color(0xff566a7f),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Screenshot review\nto be done',
                              style: kTextStyleIbmRegular.copyWith(
                                fontSize: 11.ssp(),
                                color: const Color(0xffA1ACB8),
                              ),
                            ),
                          ],
                        )),
                      ],
                    )),
              )
            ],
          ),
        ));
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
            Expanded(
              child: Padding(
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
                        onPressed: () {},
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
            ),
            Expanded(
              child: Container(
                // width: 96.51.sw(),
                // height: 155.78.sh(),
                color: Colors.tealAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
