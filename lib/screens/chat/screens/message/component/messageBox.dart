import 'package:videomanager/screens/chat/screens/conversation/model/conversationModel.dart';
import 'package:videomanager/screens/chat/screens/message/models/messageModel.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomMessageBox extends StatelessWidget {
  CustomMessageBox({Key? key, required this.message}) : super(key: key);
  final Message message;
  late bool ownMessage = checkOwnMessage(message);
  late Color color = ownMessage ? primaryColor : Colors.grey;

  bool checkOwnMessage(Message message) {
    if (message.sender=="") return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          if (ownMessage) Spacer(),
          SizedBox(
            width: 10.sw(),
          ),
          Column(
            crossAxisAlignment:
                !ownMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * .55),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sr()),
                  color: color,
                ),
                child: CustomPaint(
                  painter: ChatBoxPainter(color: color, own: ownMessage),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.ssp(), vertical: 15.ssp()),
                    child: SelectableText(
                      message.message,
                      style: kTextStyleIbmRegular.copyWith(
                          color: Colors.white, fontSize: 18.ssp()),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.sh()),
              Text(
                message.createdAt.toString().substring(0, 16),
              )
            ],
          ),
          SizedBox(
            width: 10.sw(),
          ),
          if (!ownMessage) Spacer()
        ],
      );
    });
  }
}

class ChatBoxPainter extends CustomPainter {
  ChatBoxPainter({required this.own, required this.color});
  final bool own;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Path path = Path();
    if (!own) {
      // (size.height <= 200) ? size.height : -
      path.addPolygon([
        Offset(10.sw(),
            (size.height <= 200) ? size.height * .65 : size.height * .9),
        Offset(30.sw(), size.height),
        Offset(-10.sw(), size.height),
      ], true);
    } else {
      path.addPolygon([
        Offset(size.width - 10.sw(),
            (size.height <= 200) ? size.height * .65 : size.height * .9),
        Offset(size.width - 30.sw(), size.height),
        Offset(size.width + 10.sw(), size.height),
      ], true);
    }
    path.close();
    canvas.drawPath(path, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
