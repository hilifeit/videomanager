import 'package:videomanager/screens/others/exporter.dart';

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
            top: 19.sh(), left: 24.sw(), bottom: 20.sh(), right: 10.sw()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
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
                    'Screenshot target',
                    style: kTextStyleIbmRegular.copyWith(
                        fontSize: 13.ssp(),
                        color: Theme.of(context).primaryColor),
                  ),
                  const Spacer(),
                  Text(
                    '100k',
                    style: kTextStyleIbmSemiBold.copyWith(
                        fontSize: 22.ssp(),
                        color: Theme.of(context).primaryColor),
                  ),
                  const Spacer(),
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
            // SizedBox(
            //   width: 15.sw(),
            // ),
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
