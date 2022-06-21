import 'package:videomanager/screens/others/exporter.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({
    Key? key,
    required this.message,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.sh(),
      width: 345.sw(),
      child: Row(
        children: [
          Container(
            height: 26.sh(),
            width: 3.sh(),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.sr()),
            ),
          ),
          SizedBox(
            width: 11.6.sw(),
          ),
          CircleAvatar(
            radius: 13.sr(),
            backgroundColor: color,
            child: Icon(
              icon,
              size: 20.sr(),
              // color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15.sw(),
          ),
          Text(
            message.toString(),
            style: kTextStyleInterMedium.copyWith(
                fontSize: 18.ssp(), color: color),
          ),
        ],
      ),
    );
  }
}
