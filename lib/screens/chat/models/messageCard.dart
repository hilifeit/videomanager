import 'package:videomanager/screens/others/exporter.dart';

Container messageCard() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.sw()),
    height: 50.sh(),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              clipBehavior: Clip.none,
              borderRadius: BorderRadius.circular(20.sr()),
              child: Image.network(
                'https://flyclipart.com/thumb2/dead-man-icons-download-free-png-and-vector-icons-unlimited-692263.png',
                // height: 40.sh(),
                width: 40.sr(),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -3,
              child: CircleAvatar(
                radius: 8.sr(),
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 6.sr(),
                  backgroundColor: sucess,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 30.sw(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: kTextStyleIbmSemiBold.copyWith(
                  fontSize: 14.ssp(), color: Colors.black),
            ),
            SizedBox(
              height: 5.sh(),
            ),
            Text('Message',
                style: kTextStyleIbmRegularBlack.copyWith(fontSize: 14.ssp())),
          ],
        ),
        Spacer(),
        Text(
          DateTime.now().toString().substring(0, 16),
          style: kTextStyleIbmRegular.copyWith(
              fontSize: 14.ssp(), color: lightBlack),
        ),
      ],
    ),
  );
}
