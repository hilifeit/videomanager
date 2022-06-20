import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/viewscreen/components/pathPainter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

final selectedFileProvider = StateProvider<FileDetailMini?>((ref) {
  return;
});

class MapScreen extends StatefulWidget {
  final bool isvisible, draw, miniMap;
  final MapController controller;
  const MapScreen(
      {this.isvisible = true,
      required this.controller,
      this.draw = false,
      this.miniMap = true});

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
        final selectedFile = ref.watch(selectedFileProvider.state).state;

        return LayoutBuilder(builder: (context, constraint) {
          return MapLayoutBuilder(
            controller: widget.controller,
            builder: (context, transformer) {
              transformer.controller.addListener(() {
                setState(() {});
              });

              // transformer.controller.center = LatLng(
              //     fileService.files[10].location.coordinates[0][1],
              //     fileService.files[10].location.coordinates[0][0]);

              // transformer.controller.zoom = 20;

              final markerWidgets = [
                ClipRRect(
                  child: Stack(children: [
                    CanvasTouchDetector(
                        gesturesToOverride: const [
                          GestureType.onTapUp,
                          GestureType.onTapDown,
                          GestureType.onSecondaryTapDown,
                          GestureType.onSecondaryTapUp,
                        ],
                        builder: (context) {
                          return CustomPaint(
                            size:
                                Size(constraint.maxWidth, constraint.maxHeight),
                            painter: Painter(
                              context,
                              ref,
                              files: widget.draw ? fileService.files : [],
                              selectedFileProvider: selectedFileProvider,
                              transformer: transformer,
                            ),
                          );
                        })
                  ]),
                )
              ];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _onDoubleTap,
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
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
                      Stack(
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
                          Container(
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      ...markerWidgets,
                      if (widget.miniMap)
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onDoubleTap: () {},
                              onTap: () async {
                                transformer.controller.center = LatLng(
                                    selectedFile!.boundingBox!.center.dx,
                                    selectedFile.boundingBox!.center.dy);
                                await Clipboard.setData(
                                    ClipboardData(text: selectedFile.id));
                              },
                              onScaleStart: (detail) {},
                              onScaleEnd: (detail) {},
                              child: Stack(
                                children: [
                                  AnimatedOpacity(
                                    opacity: selectedFile == null ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SizedBox(
                                          width: 613.sw(),
                                          height: 188.sh(),
                                          child: const VideoDetails(
                                            showMap: false,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
        visible: widget.isvisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 54.sr(),
              width: 54.sr(),
              child: CustomFloatingActionButton(
                  icon: Videomanager.location,
                  onPressed: () {
                    setState(() {
                      _gotoDefault();
                    });
                  },
                  roundShape: true,
                  tooltip: 'My location'),
            ),
            SizedBox(
              height: 32.sh(),
            ),
            SizedBox(
              height: 54.sr(),
              width: 54.sr(),
              child: CustomFloatingActionButton(
                  icon: Icons.add,
                  onPressed: () async {
                    widget.controller.zoom += 1;
                    CustomKeys().ref!.read(snackVisibleProvider.state).state =
                        true;

                    var closed = await CustomKeys()
                        .messengerKey
                        .currentState!
                        .showSnackBar(SnackBar(
                          content: const Text(
                            'test',
                          ),
                          onVisible: () {},
                        ))
                        .closed;

                    CustomKeys().ref!.read(snackVisibleProvider.state).state =
                        false;
                    setState(() {});
                  },
                  tooltip: 'Zoom in'),
            ),
            SizedBox(
              height: 54.sr(),
              width: 54.sr(),
              child: CustomFloatingActionButton(
                  icon: Icons.remove,
                  onPressed: () {
                    setState(() {
                      widget.controller.zoom -= 1;
                    });
                  },
                  tooltip: "Zoom out"),
            ),
            SizedBox(
              height: 19.sh(),
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
          borderRadius: !roundShape
              ? BorderRadius.zero
              : BorderRadius.circular(100.sr())),
      backgroundColor: Colors.white,
      onPressed: () {
        onPressed();
      },
      tooltip: tooltip!,
      child: Icon(
        icon,
        size: 28.sr(),
        color: Colors.black,
      ),
    );
  }
}
