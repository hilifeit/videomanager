import 'package:videomanager/screens/others/exporter.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffff0f0),
      child: Padding(
        padding: EdgeInsets.only(top: 20.sh(), left: 21.sw(), bottom: 10.sh()),
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
                    // width: 99.sw(),
                    color: Colors.tealAccent,
                  ),
                ],
              ),
            ),
            // const Spacer(),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
