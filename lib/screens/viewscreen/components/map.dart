import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/components/contextmenu/contextmenu.dart';
import 'package:videomanager/screens/viewscreen/components/pathPainter.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class MapScreen extends StatefulWidget {
  final bool? isvisible;
  final MapController controller;
  MapScreen({this.isvisible = true, required this.controller});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _gotoDefault() {
    widget.controller.center = LatLng(27.7251933, 85.3411312);
    setState(() {});
  }

  void _onDoubleTap() {
    widget.controller.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      // widget.controller.zoom += 0.02;
      widget.controller.zoom += 1;
      setState(() {});
    } else if (scaleDiff < 0) {
      widget.controller.zoom -= 1;
      // widget.controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      widget.controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, c) {
        final fileService = ref.watch(fileDetailMiniServiceProvider);

        return LayoutBuilder(builder: (context, constraint) {
          return MapLayoutBuilder(
            controller: widget.controller,
            builder: (context, transformer) {
              transformer.controller.addListener(() {
                setState(() {});
              });
              final markerWidgets = [
                ClipRRect(
                  child: Stack(children: [
                    CustomPaint(
                      size: Size(constraint.maxWidth, constraint.maxHeight),
                      painter: Painter(
                        files: fileService.files,
                        // currentIndex: 0,
                        // data: geoFiles,
                        // sample: 100,
                        transformer: transformer,
                        // selectedIndex: 0
                      ),
                    )
                  ]

                      // Transform.rotate(
                      //   angle: 0.58,
                      //   child: Container(
                      //     color: Colors.red,
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      // )

                      ),
                )
              ];
              return GestureDetector(
                onSecondaryTapUp: (details) {
                  print('local :${details.localPosition}');
                  print('global: ${details.globalPosition}');
                  print(transformer.constraints);
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          details.localPosition.dx,
                          details.localPosition.dy,
                          transformer.constraints.maxWidth -
                              details.localPosition.dx,
                          0),
                      items: [PopupMenuItem(child: Text('data'))]);
                },
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _onDoubleTap,
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                        child: Container(
                            color: Colors.white, child: ContextMenu())),
                  );
                },
                onTapUp: (details) {
                  final location =
                      transformer.fromXYCoordsToLatLng(details.localPosition);

                  //final clicked = transformer.fromLatLngToXYCoords(location);
                  //print('${location.longitude}, ${location.latitude}');
                  //print('${clicked.dx}, ${clicked.dy}');
                  //print('${details.localPosition.dx}, ${details.localPosition.dy}');

                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     content: Text(
                  //         'You have clicked on (${location.longitude}, ${location.latitude}).'),
                  //   ),
                  // );
                },
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta;

                      widget.controller.zoom -= delta.dy / 1000.0;
                      setState(() {});
                    }
                  },
                  child: Stack(
                    children: [
                      Map(
                        controller: widget.controller,
                        builder: (context, x, y, z) {
                          //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.
                          //Google Maps
                          final url =
                              'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                          return CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      ...markerWidgets
                    ],
                  ),
                ),
              );
            },
          );
        });
      }),

      // TODO: accrding to design
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: widget.isvisible!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 54.r,
              width: 54.r,
              child: CustomFloatingActionButton(
                  icon: Videomanager.location,
                  onPressed: () {
                    _gotoDefault();
                  },
                  roundShape: true,
                  tooltip: 'My location'),
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              height: 54.r,
              width: 54.r,
              child: CustomFloatingActionButton(
                  icon: Icons.add,
                  onPressed: () {
                    widget.controller.zoom += 1;
                  },
                  tooltip: 'Zoom in'),
            ),
            SizedBox(
              height: 54.r,
              width: 54.r,
              child: CustomFloatingActionButton(
                  icon: Icons.remove,
                  onPressed: () {
                    widget.controller.zoom -= 1;
                  },
                  tooltip: "Zoom out"),
            ),
            SizedBox(
              height: 19.h,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton CustomFloatingActionButton(
      {required IconData icon,
      required Function onPressed,
      bool roundShape = false,
      String? tooltip}) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
          borderRadius:
              !roundShape ? BorderRadius.zero : BorderRadius.circular(100.r)),
      backgroundColor: Colors.white,
      onPressed: () {
        onPressed();
      },
      tooltip: tooltip!,
      child: Icon(
        icon,
        size: 28.r,
        color: Colors.black,
      ),
    );
  }
}
