import 'package:socket_io_client/socket_io_client.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

final customSocket = CustomSocket._();

class CustomSocket {
  CustomSocket._();
  late Socket socket;
  connect() {
    try {
      var user = CustomKeys().ref!.read(userChangeProvider).loggedInUser.value;
      if (user != null) {
        socket = io(
            CustomIP.socketBaseUrl,
            OptionBuilder()
                .setTransports(['websocket'])
                .disableAutoConnect()
                .setQuery({"token": user.accessToken})
                .build());
        if (!socket.connected) {
          socket.connect();
          socket.onConnect((data) => print("Connected: $data"));
          socket.onConnectError((data) => snack.error(data));
          socket.onConnectTimeout((data) => snack.error(data));
          socket.onError((data) => snack.error(data));
          socket.onDisconnect((data) => null);
          socket.on("notification", (data) {
            snack.info(data);
          });
          socket.on("active", (data) {
            CustomKeys()
                .ref!
                .read(userChangeProvider)
                .changeActiveStatus(id: data, isActive: true);
          });

          socket.on("message", (data) {});

          socket.on("inActive", (data) {
            CustomKeys()
                .ref!
                .read(userChangeProvider)
                .changeActiveStatus(id: data, isActive: false);
          });

          socket.on("typing", (data) {
            CustomKeys().ref!.read(userChangeProvider).changeIsTyping(data);
          });

          socket.on("activeUsers", (data) {
            if (data != null) {
              CustomKeys()
                  .ref!
                  .read(userChangeProvider)
                  .getActiveUsers(List<String>.from(jsonDecode(data)));
            }
          });
        }
      } else {
        print("no user");
      }
    } catch (e) {
      print('$e');
    }
  }

  disconnect() {
    if (socket.connected) socket.disconnect();
  }
}
