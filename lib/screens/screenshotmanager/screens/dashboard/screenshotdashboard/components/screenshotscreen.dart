import 'dart:typed_data';

import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/addshop.dart';

class ScreenShotScreen extends ConsumerWidget {
   ScreenShotScreen({
    Key? key,
    required this.imageData
  }) : super(key: key);
final Uint8List imageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posiionProvider = StateProvider<Offset>((ref) {
      return Offset(0, 0);
    });
    return Container(
      color: whiteColor,
      child: Center(
        child: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                  color: whiteColor,
                  image: DecorationImage(
                    opacity: 1,
                    image:MemoryImage(imageData),
                    fit: BoxFit.contain,
                  )),
              child: ClipPath(
                  clipper: ScreenShotClipper(),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.grab,
                    onHover: (event) {
                      ref.read(posiionProvider.state).state =
                          event.localPosition;
                    },
                    child: GestureDetector(
                      onTap: () {
                        item.add(CustomPaint(
                          painter: ShopPinPainter(
                              color: primaryColor,
                              pinPosition:
                                  ref.watch(posiionProvider.state).state),
                        ));
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return Center(child: AddEditShop());
                            }));
                      },
                      child: Stack(
                        children: [
                          // Image.asset(
                          //   "assets/images/wallpaper.jpg",
                          // ),
                          for (int i = 0; i < item.length; i++) item[i],
                        ],
                      ),
                    ),
                  )),
            ),
            Positioned(
              bottom: 46.sh(),
              right: 54.sw(),
              child: Row(
                children: [
                  CustomOutlinedButton(
                      borderColor: whiteColor,
                      onPressedOutlined: () {
                        item.clear();
                      },
                      outlinedButtonText: 'Clear All'),
                  SizedBox(
                    width: 25.sw(),
                  ),
                  CustomOutlinedButton(
                      borderColor: whiteColor,
                      onPressedOutlined: () {
                        Navigator.pop(context);
                      },
                      outlinedButtonText: 'Cancel'),
                  SizedBox(
                    width: 25.sw(),
                  ),
                  CustomElevatedButton(
                      enabled: false,
                      onPressedElevated: () {},
                      elevatedButtonText: 'Confirm(5)')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> item = [];
}

class ShopPinPainter extends CustomPainter {
  ShopPinPainter({required this.color, required this.pinPosition});
  final Offset pinPosition;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Path path = Path();

    // path.addRect(Rect.fromLTWH(pinPosition.dx, pinPosition.dy, 10, 20));
    const icon = Icons.location_on;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: 40.0, fontFamily: icon.fontFamily, color: color));
    textPainter.layout();
    textPainter.paint(canvas, pinPosition);

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

class ScreenShotClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(Rect.fromCenter(
          center: Offset(size.width / 2 - 50.sw(), size.height / 2 - 50.sh()),
          width: size.width * 0.788,
          height: size.height * 0.68));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
