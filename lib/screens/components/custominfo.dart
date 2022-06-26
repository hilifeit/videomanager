import 'package:videomanager/screens/others/exporter.dart';

class CustomShowMessage {
  CustomShowMessage._();

  static nodata() {
    return const CustomInfo(
      buttonShow: false,
      image: 'nodata',
      textBold: 'NO DATA',
      textDetail: 'Please check your database\nsince no data available.',
    );
  }

  static nointernet() {
    return const CustomInfo(
      buttonShow: true,
      image: 'nointernet',
      textBold: 'NO INTERNET',
      textDetail: 'Please check your internet connection.',
    );
  }
}

class CustomInfo extends StatelessWidget {
  const CustomInfo(
      {Key? key,
      required this.image,
      required this.textBold,
      required this.textDetail,
      required this.buttonShow})
      : super(key: key);
  final String image, textBold, textDetail;
  final bool buttonShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.sh(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                height: 160.4.sh(),
                width: 174.4.sw(),
                image: AssetImage('assets/images/$image.png')),
            // SizedBox(
            //   width: 20.sw(),
            // ),
          ],
        ),
        SizedBox(
          height: 10.sh(),
        ),
        Text(
          textBold,
          style: kTextStyleInterMedium.copyWith(
            fontSize: 20.ssp(),
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10.sh(),
        ),
        Text(
          textAlign: TextAlign.center,
          textDetail,
          style: kTextStyleInterSemiBold.copyWith(
            fontSize: 16.ssp(),
            color: secondaryColorText,
          ),
        ),
        SizedBox(
          height: 10.sh(),
        ),
        if (buttonShow)
          Button(
              width: 106.sw(),
              onPressed: () {},
              label: 'Retry',
              kLabelTextStyle: kTextStyleInterSemiBold.copyWith(
                fontSize: 14.ssp(),
                color: Colors.white,
              ))
      ],
    );
  }
}
