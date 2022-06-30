import 'package:http/http.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

Future<Response> tunnelRequest(Future<Response> Function() mainFuction) async {
  try {
    var resp = await mainFuction();
    if (resp.statusCode == 403) {
      if (await CustomKeys().ref!.read(userChangeProvider).getToken()) {
        return await mainFuction();
      } else {
        await CustomDialogBox.alertMessage(() {
          logout();
        }, title: 'Your Session has Expired!', message: ' Login to continue');

        return Response('{"message":"logout"}', 406);
      }
    } else {
      return resp;
    }
  } catch (e) {
    rethrow;
  }
}
