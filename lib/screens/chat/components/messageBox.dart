import 'package:videomanager/screens/others/exporter.dart';

class CustomMessageBox extends StatelessWidget {
  CustomMessageBox(
      {Key? key,
      this.ownMessage = false,
      required this.message,
      this.messageTime})
      : super(key: key);

  final bool ownMessage;
  late Color color = ownMessage ? primaryColor : Colors.grey;
  final String message;
  DateTime? messageTime;
  @override
  Widget build(BuildContext context) {
    messageTime ??= DateTime.now();
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          if (ownMessage) Spacer(),
          Column(
            crossAxisAlignment:
                !ownMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * .65),
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
                      message,
                      style: kTextStyleIbmRegular.copyWith(
                          color: Colors.white, fontSize: 18.ssp()),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.sh()),
              Text(
                messageTime.toString().substring(0, 16),
              )
            ],
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
