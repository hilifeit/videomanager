import 'package:videomanager/screens/others/exporter.dart';

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
            top: 20.sh(), left: 21.sw(), right: 10.sw(), bottom: 20.sh()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
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
                        fontSize: 15.ssp(), color: notExactlyPrimary),
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
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
