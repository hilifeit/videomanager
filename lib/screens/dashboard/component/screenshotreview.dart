import 'package:videomanager/screens/others/exporter.dart';

class ScreenShotReview extends StatelessWidget {
  const ScreenShotReview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          color: const Color(0xffF4FCFF),
          child: Padding(
            padding: EdgeInsets.only(top: 10.sh(), bottom: 15.sh()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sw()),
                  child: Text(
                    'Screenshot Review',
                    style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 14.ssp(),
                      color: const Color(0xff697A8D),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.sh(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 102.sr(),
                      height: 102.sr(),
                      child: Padding(
                        padding: EdgeInsets.all(4.sr()),
                        child: CustomPaint(
                          painter: CustomScreenshotMarkPainter(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '72%',
                                style: kTextStyleIbmSemiBold.copyWith(
                                  fontSize: 20.ssp(),
                                  color: const Color(0xff566a7f),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Screenshot review\nto be done',
                                style: kTextStyleIbmRegular.copyWith(
                                  fontSize: 10.ssp(),
                                  color: const Color(0xffA1ACB8),
                                ),
                              ),
                            ],
                          ),
                          // size: Size(102.sr(), 102.sr(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }
}

class CustomScreenshotMarkPainter extends CustomPainter {
  final double width = 10.sr(), height = 18.sr();
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    Path path = Path();

    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(-width, (size.height / 2) - (height / 2), width, height),
        const Radius.circular(4)));
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
            size.width, (size.height / 2) - (height / 2), width, height),
        const Radius.circular(4)));
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH((size.width / 2) - (width), -height / 2, height, width),
        const Radius.circular(4)));
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH((size.width / 2) - (width), size.height, height, width),
        const Radius.circular(4)));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
