import 'dart:typed_data';

import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/addshop.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/model/snapModel.dart';

import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/service/videoDataDetail.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class ScreenShotScreen extends StatefulHookConsumerWidget {
  ScreenShotScreen(
      {Key? key, this.edit = false, this.thumb, this.duration, this.id})
      : super(key: key);
  final bool edit;
  final String? id;
  final Duration? duration;
  final Uint8List? thumb;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScreenShotScreenState();
}

class _ScreenShotScreenState extends ConsumerState<ScreenShotScreen> {
  late Future<Uint8List?> imageFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageFuture = fetchImage();
  }

  Future<Uint8List?> fetchImage() async {
    Uint8List? image;
    var videoDataDetailService = ref.read(videoDataDetailServiceProvider);
    if (videoDataDetailService.selectedSnap.value != null) {
      if (videoDataDetailService.selectedSnap.value!.image == null) {
        image = await ref
            .read(fileDetailMiniServiceProvider)
            .getFrameFromUrl(id: widget.id!, duration: widget.duration!);

        if (image != null) {
          videoDataDetailService.selectedSnap.value!.image = image;
        }
      }
    }

    return image;
  }

  bool isZoomed = false;

  @override
  Widget build(BuildContext context) {
    final snapService = ref.watch(videoDataDetailServiceProvider);
    final snap = snapService.selectedSnap.value;
    final drag = snapService.drag;

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      child: LayoutBuilder(builder: (context, constraint) {
        // print('$constraint ${MediaQuery.of(context).size}');
        return snap != null
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                  ),
                  InteractiveViewer(
                    onInteractionUpdate: (details) {
                      print(details);
                    },
                    maxScale: 4,
                    child: Stack(
                      children: [
                        if (snap.image == null)
                          Image.memory(
                            widget.thumb!,
                            width: constraint.maxWidth,
                            height: constraint.maxHeight,
                            fit: BoxFit.fill,
                          ),
                        FutureBuilder<Uint8List?>(
                            future: imageFuture,
                            builder: (context, snapshot) {
                              Uint8List? img;
                              if (snap.image != null) {
                                img = snap.image!;
                              } else {
                                if (snapshot.hasData) {
                                  img = snapshot.data!;
                                } else {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child:
                                          Text("Original Image load Failed!"),
                                    );
                                  }
                                  // return const Center(
                                  //     child: CircularProgressIndicator());
                                }
                              }

                              return AnimatedOpacity(
                                key: const Key("anim"),
                                opacity: img == null ? 0 : 1,
                                duration: const Duration(milliseconds: 1000),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          // color: whiteColor,
                                          image: DecorationImage(
                                        opacity: 1,
                                        image:
                                            MemoryImage(img ?? widget.thumb!),
                                        fit: BoxFit.fill,
                                      )),
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
                                            size: Size(constraint.maxWidth,
                                                constraint.maxHeight),
                                            painter: ShopPinPainter(
                                                ref: ref,
                                                context: context,
                                                imageData:
                                                    img ?? widget.thumb!),
                                          );
                                        },
                                      ),
                                    ),
                                    if (snap.shops.isNotEmpty)
                                      for (var element in snap.shops)
                                        for (var e in element.area)
                                          Positioned(
                                            left: (constraint.maxWidth / e.dx) -
                                                (12.sr() / 2),
                                            top: (constraint.maxHeight / e.dy) -
                                                (12.sr() / 2),
                                            child: Builder(builder: (context) {
                                              pointDrag(Offset details) {
                                                var dragRatio = Offset(
                                                    constraint.maxWidth /
                                                        details.dx,
                                                    constraint.maxHeight /
                                                        details.dy);
                                                int indexPoint =
                                                    element.area.indexOf(e);
                                                int indexShop =
                                                    snap.shops.indexOf(element);
                                                snapService.dragUpdate(
                                                    dragRatio,
                                                    indexPoint,
                                                    indexShop);
                                              }

                                              return Draggable(
                                                onDragUpdate: (details) {
                                                  pointDrag(
                                                      details.localPosition);
                                                },
                                                // onDragEnd: (details) {
                                                //   pointDrag(details.offset);
                                                // },
                                                feedback: Container(
                                                  height: 12.sr(),
                                                  width: 12.sr(),
                                                  decoration: BoxDecoration(
                                                      color: element.color,
                                                      shape: BoxShape.circle),
                                                ),
                                                childWhenDragging: Container(),
                                                child: Container(
                                                  height: 12.sr(),
                                                  width: 12.sr(),
                                                  decoration: BoxDecoration(
                                                      color: element.color,
                                                      shape: BoxShape.circle),
                                                ),
                                              );
                                            }),
                                          )
                                  ],
                                ),
                              );
                            }),
                      ],
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

// class ShopAreaPoints extends StatelessWidget {
//   const ShopAreaPoints(
//       {Key? key,
//       required this.snap,
//       required this.snapService,
//       required this.constraint})
//       : super(key: key);

//   final SnapModel? snap;
//   final VideoDataDetail snapService;
//   final BoxConstraints constraint;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: constraint.maxWidth / snap!.shops.first.area[1].dx,
//       top: constraint.maxHeight / snap!.shops.first.area[1].dy,
//       child: Draggable(
//         onDragEnd: (details) {
//           var dragRatio = Offset(constraint.maxWidth / details.offset.dx,
//               constraint.maxHeight / details.offset.dy);
//           snapService.dragUpdate(dragRatio);
//         },
//         feedback: Container(
//           height: 20,
//           width: 20,
//           decoration: const BoxDecoration(
//               color: Colors.lightGreenAccent, shape: BoxShape.circle),
//         ),
//         childWhenDragging: Container(),
//         child: Container(
//           height: 20,
//           width: 20,
//           decoration: const BoxDecoration(
//               color: Colors.lightGreenAccent, shape: BoxShape.circle),
//         ),
//       ),
//     );
//   }
// }

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
    double boxIconSize = 40.ssp();
    newCanvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), boxPaint,
        hitTestBehavior: HitTestBehavior.translucent, onTapUp: (details) async {
      var color = primaryColor;
      if (!UniversalPlatform.isWeb) {
        color = await getColorFromImagePixel(
            imageData: imageData, pixelPosition: details.localPosition);
      }
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
        Offset ratio = Offset(size.width / details.localPosition.dx,
            size.height / details.localPosition.dy);
        shop.area.clear();

        shop.area.addAll([
          Offset(size.width / (details.localPosition.dx - boxIconSize),
              size.height / (details.localPosition.dy - boxIconSize * 1.5)),
          Offset(size.width / (details.localPosition.dx + boxIconSize),
              size.height / (details.localPosition.dy - boxIconSize * 1.5)),
          Offset(size.width / (details.localPosition.dx + boxIconSize),
              size.height / (details.localPosition.dy + boxIconSize)),
          Offset(size.width / (details.localPosition.dx - boxIconSize),
              size.height / (details.localPosition.dy + boxIconSize))
        ]);

        shop.position = ratio;
        snapService.addShop(shop);
      }
    });

    for (var element in shops) {
      drawIcon(canvas, element.color, element.position, size, boxIconSize);
      // TODO Delete the

      Offset position = Offset(
          size.width / element.position.dx, size.height / element.position.dy);

      //Single Marker Touchy Start
      newCanvas.drawRect(
          Rect.fromCenter(
              center: Offset(position.dx, position.dy - iconSize * .4),
              width: iconSize * .6,
              height: iconSize * .9),
          boxPaint, onTapUp: (details) async {
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
      }, onSecondaryTapUp: (details) {
        snapService.removeShop(element);
      }, onPanStart: (details) {}, onPanUpdate: (details) {});
      Paint areaBoxPaint = Paint()
        ..color = element.color.withAlpha(150)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      var path = Path();
      path.addPolygon(
          element.area
              .map((e) => Offset(size.width / e.dx, size.height / e.dy))
              .toList(),
          true);
      canvas.drawPath(path, areaBoxPaint);
      //Single Marker Touchy End
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  drawIcon(Canvas canvas, Color color, Offset pinPosition, Size size,
      double iconSize) {
    Offset position =
        Offset(size.width / pinPosition.dx, size.height / pinPosition.dy);

    const icon = Icons.location_on;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: iconSize, fontFamily: icon.fontFamily, color: color));
    textPainter.layout();
    Offset fixedPosition =
        Offset(position.dx - iconSize / 2, position.dy - iconSize * 0.9);
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
