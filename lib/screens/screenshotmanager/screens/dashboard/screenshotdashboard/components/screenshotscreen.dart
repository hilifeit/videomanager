import 'dart:typed_data';

import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/addshop.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';

import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';

class ScreenShotScreen extends ConsumerWidget {
  ScreenShotScreen({Key? key, this.edit = false}) : super(key: key);
  final bool edit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapService = ref.watch(videoDataDetailServiceProvider);
    final snap = snapService.selectedSnap.value;
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      child: LayoutBuilder(builder: (context, constraint) {
        // print('$constraint ${MediaQuery.of(context).size}');
        return snap != null
            ? Stack(
                children: [
                  InteractiveViewer(
                    maxScale: 4,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: snap.image != null
                          ? BoxDecoration(
                              color: whiteColor,
                              image: DecorationImage(
                                opacity: 1,
                                image: MemoryImage(snap.image!),
                                fit: BoxFit.fill,
                              ))
                          : const BoxDecoration(
                              color: whiteColor,
                            ),
                      child: CanvasTouchDetector(
                        gesturesToOverride: const [
                          GestureType.onTapUp,
                          GestureType.onTapDown,
                          GestureType.onSecondaryTapUp,
                          GestureType.onPanUpdate,
                          GestureType.onPanStart,
                        ],
                        builder: (context) {
                          return CustomPaint(
                            size:
                                Size(constraint.maxWidth, constraint.maxHeight),
                            painter: ShopPinPainter(
                                ref: ref,
                                context: context,
                                imageData: snap.image!),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 46.sh(),
                    right: 54.sw(),
                    child: Row(
                      children: [
                        CustomOutlinedButton(
                            borderColor: whiteColor,
                            onPressedOutlined: snap.shops.isEmpty
                                ? null
                                : () {
                                    snapService.clearShop();
                                  },
                            outlinedButtonText: 'Clear All'),
                        SizedBox(
                          width: 25.sw(),
                        ),
                        CustomOutlinedButton(
                            borderColor: whiteColor,
                            onPressedOutlined: () {
                              Navigator.pop(context);
                              snapService.cancelNewSnap();
                            },
                            outlinedButtonText: 'Cancel'),
                        SizedBox(
                          width: 25.sw(),
                        ),
                        CustomElevatedButton(
                            onPressedElevated: snap.shops.isNotEmpty
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : null,
                            elevatedButtonText:
                                'Confirm${snap.shops.isEmpty ? '' : " (${snap.shops.length})"}')
                      ],
                    ),
                  ),
                ],
              )
            : Container();
      }),
    );
  }
}

class ShopPinPainter extends CustomPainter {
  ShopPinPainter(
      {required this.ref, required this.context, required this.imageData});
  final WidgetRef ref;
  final BuildContext context;
  final Uint8List imageData;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    Path path = Path();
    double iconSize = 40.ssp();

    Paint boxPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.transparent;
    // path.addRect(Rect.fromLTWH(pinPosition.dx, pinPosition.dy, 10, 20));
    var snapService = ref.read(videoDataDetailServiceProvider);
    var shops = snapService.selectedSnap.value!.shops;

    TouchyCanvas newCanvas = TouchyCanvas(context, canvas);

    newCanvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), boxPaint,
        hitTestBehavior: HitTestBehavior.translucent, onTapUp: (details) async {
      var color = await getColorFromImagePixel(
          imageData: imageData, pixelPosition: details.localPosition);
      Shop newShop = Shop.empty()..color = color;

      var data = await showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: AddEditShop(
                shop: newShop,
              ),
            );
          });
      if (data != null) {
        Shop shop = data as Shop;
        shop.position = details.localPosition;
        snapService.addShop(shop);
      }
    });

    for (var element in shops) {
      drawIcon(canvas, element.color, element.position);
      //Single Marker Touchy Start
      newCanvas.drawRect(
          Rect.fromCenter(
              center: Offset(
                  element.position.dx, element.position.dy - iconSize * .4),
              width: iconSize * .6,
              height: iconSize * .9),
          boxPaint,
          onTapUp: (details) async {
            //Left Click Action
            var data = await showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: AddEditShop(
                      edit: true,
                      shop: element,
                    ),
                  );
                });
            if (data != null) {
              // Shop shop = data as Shop;
              // shop.position = details.localPosition;
              // snapService.removeShop(element);
              // snapService.addShop(shop);
            }

            //Right Click Action
          },
          onSecondaryTapUp: (details) {
            snapService.removeShop(element);
          },
          onPanStart: (details) {},
          onPanUpdate: (details) {
            print(details.localPosition);
          });
      //Single Marker Touchy End
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  drawIcon(Canvas canvas, Color color, Offset pinPosition) {
    double iconSize = 40.ssp();
    const icon = Icons.location_on;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: iconSize, fontFamily: icon.fontFamily, color: color));
    textPainter.layout();
    Offset fixedPosition =
        Offset(pinPosition.dx - iconSize / 2, pinPosition.dy - iconSize * 0.9);
    textPainter.paint(canvas, fixedPosition);
  }
}

class ScreenShotClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromCenter(
            center: Offset(size.width / 2 - 50.sw(), size.height / 2 - 50.sh()),
            width: size.width * 0.788,
            height: size.height * 0.68),
      )
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
