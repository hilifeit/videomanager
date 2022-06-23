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
      height: 60.sh(),
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
          Icon(
            icon,
            size: 26.sr(),
            color: color,
          ),
          SizedBox(
            width: 15.sw(),
          ),
          Expanded(
            child: Text(
              message.toString(),
              maxLines: 2,
              style: kTextStyleInterMedium.copyWith(
                  fontSize: 16.ssp(), color: color),
            ),
          ),
        ],
      ),
    );
  }
}
