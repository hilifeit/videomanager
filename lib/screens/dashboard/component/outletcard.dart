import 'package:videomanager/screens/others/exporter.dart';

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
            top: 14.sh(), left: 19.sw(), bottom: 17.sh(), right: 16.sw()),
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
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 8.sh(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.sr())),
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                        value: 0.5,
                        backgroundColor: const Color(0xffECEEF1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.sw()),
                Expanded(
                  child: Text(
                    '50%',
                    style: kTextStyleIbmRegular.copyWith(
                      fontSize: 13.ssp(),
                      color: cardHeader,
                    ),
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
