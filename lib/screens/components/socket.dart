import 'package:socket_io_client/socket_io_client.dart';
import 'package:videomanager/screens/others/exporter.dart';

const String socketUrl = 'http://192.168.16.106:3000';
final customSocket = CustomSocket._();

class CustomSocket {
  CustomSocket._();
  late Socket socket;
  connect() {
    try {
      socket = io(
          socketUrl,
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      if (!socket.connected) {
        socket.connect();
        socket.onConnect((data) => print("Connected: $data"));
        socket.onConnectError((data) => snack.error(data));
        socket.onConnectTimeout((data) => snack.error(data));
        socket.onDisconnect((data) => null);
        socket.on("notification", (data) {
          snack.info(data);
        });
      }
    } catch (e) {
      print('$e');
    }
  }

  disconnect() {
    if (socket.connected) socket.disconnect();
  }
}
