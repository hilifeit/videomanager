import 'package:videomanager/screens/components/snackbar/snackbarcontent.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomSnackBar {
  success(dynamic message) {
    showSnackBar(
        color: Colors.green,
        content: CustomSnackBarContent(
          icon: Icons.check_circle,
          message: message.toString(),
          color: Colors.green,
        ));
  }

  error(dynamic message) {
    showSnackBar(
        color: danger.withAlpha(127),
        content: CustomSnackBarContent(
          icon: Icons.close_sharp,
          message: message.toString(),
          color: danger,
        ));
  }

  info(dynamic message) {
    showSnackBar(
        color: primaryColor,
        content: CustomSnackBarContent(
          color: primaryColor,
          icon: Icons.dangerous,
          message: message.toString(),
        ));
  }

  Future showSnackBar({required Widget content, required Color color}) async {
    CustomKeys().ref!.read(snackVisibleProvider.state).state = true;
    if (CustomKeys().messengerKey.currentState != null) {
      await CustomKeys()
          .messengerKey
          .currentState!
          .showSnackBar(SnackBar(
            padding: EdgeInsets.symmetric(
              horizontal: 5.sw(),
              vertical: 4.sh(),
            ),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.sr())),
            duration: const Duration(seconds: 2),
            content: content,
            onVisible: () {},
          ))
          .closed;
      CustomKeys().ref!.read(snackVisibleProvider.state).state = false;
    }
  }
}
