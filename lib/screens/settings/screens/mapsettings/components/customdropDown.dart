import 'package:videomanager/screens/others/exporter.dart';

class TextWithDDownButton extends StatelessWidget {
  const TextWithDDownButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.sw(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
          ),
          Placeholder(fallbackWidth: 106.sw(), fallbackHeight: 49.sh()),
        ],
      ),
    );
  }
}
