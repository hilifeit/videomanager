import 'package:videomanager/screens/components/snackbar/snackbarcontent.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomSnackBar {
  success(dynamic message) {
    showSnackBar(
        color: sucessSecondary,
        content: CustomSnackBarContent(
          icon: Videomanager.sucess,
          message: message.toString(),
          color: sucess,
        ));
  }

  error(dynamic message) {
    showSnackBar(
        color: dangerSecondary,
        content: CustomSnackBarContent(
          icon: Videomanager.close,
          message: message.toString(),
          color: danger,
        ));
  }

  info(dynamic message) {
    showSnackBar(
        color: primarySecondary,
        content: CustomSnackBarContent(
          color: primaryColor,
          icon: Videomanager.info,
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
