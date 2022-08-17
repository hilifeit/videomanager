import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/assignuser/assignmanager.dart';
import 'package:videomanager/screens/components/clippedholder.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';
import 'package:videomanager/screens/viewscreen/components/pathPainter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final selectedFileProvider = StateProvider<FileDetailMini?>((ref) {
  return;
});

class MapScreen extends ConsumerStatefulWidget {
  final bool isvisible, draw, miniMap;
  final MapController controller;
  const MapScreen(
      {this.isvisible = true,
      required this.controller,
      this.draw = false,
      this.miniMap = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final List<Offset> selectedArea = [];
  void _gotoDefault() {
    widget.controller.center = LatLng(27.7251933, 85.3411312);
    setState(() {});
  }

  void _onDoubleTap() {
    widget.controller.zoom +=
        ref.read(settingChangeNotifierProvider).setting.mapSetting.zoom / 2;
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
      widget.controller.zoom +=
          ref.read(settingChangeNotifierProvider).setting.mapSetting.zoom;
      setState(() {});
    } else if (scaleDiff < 0) {
      widget.controller.zoom -=
          ref.read(settingChangeNotifierProvider).setting.mapSetting.zoom;
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
              SelectedArea.transformer = transformer;
              transformer.controller.addListener(() {
                setState(() {});
              });

              // transformer.controller.center = LatLng(
              //     fileService.files[10].location.coordinates[0][1],
              //     fileService.files[10].location.coordinates[0][0]);

              // transformer.controller.zoom = 20;

              final markerWidgets = ClipRRect(
                child: CanvasTouchDetector(
                    gesturesToOverride: const [
                      GestureType.onTapUp,
                      GestureType.onTapDown,
                      GestureType.onSecondaryTapDown,
                      GestureType.onSecondaryTapUp,
                      GestureType.onForcePressEnd,
                      GestureType.onLongPressEnd,
                      GestureType.onLongPressStart,

                      // GestureType.onLongPressMoveUpdate
                    ],
                    builder: (context) {
                      return CustomPaint(
                        size: Size(constraint.maxWidth, constraint.maxHeight),
                        painter: Painter(
                          context,
                          ref,
                          selectedFileProvider: selectedFileProvider,
                          transformer: transformer,
                        ),
                      );
                    }),
              );

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _onDoubleTap,
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerUp: (detail) {
                    // if (detail.kind == PointerDeviceKind.mouse &&
                    //     detail.buttons == kSecondaryMouseButton)
                    {
                      var selectedPointService =
                          ref.read(selectedAreaServiceProvider);
                      selectedPointService.deSelectHandle();
                    }
                  },
                  onPointerHover: (details) {
                    ref
                        .read(selectedAreaServiceProvider)
                        .moveHandle(newPosition: details.localPosition);
                  },
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta;

                      widget.controller.zoom -= delta.dy /
                          (1010 -
                              mapDouble(
                                  x: ref
                                      .read(settingChangeNotifierProvider)
                                      .setting
                                      .mapSetting
                                      .scroll
                                      .toDouble(),
                                  in_min: 10,
                                  in_max: 100,
                                  out_min: 10,
                                  out_max: 1000));

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
                            color: Theme.of(context).primaryColor.withAlpha(30),
                          ),
                        ],
                      ),
                      if (widget.draw) Listener(child: markerWidgets),
                      if (widget.miniMap)
                        if (selectedFile != null)
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onDoubleTap: () {},
                                onTap: () async {
                                  transformer.controller.center = LatLng(
                                      selectedFile.boundingBox!.center.dx,
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SizedBox(
                                            width: ResponsiveLayout.isDesktop
                                                ? 613.sw()
                                                : transformer
                                                        .constraints.maxWidth *
                                                    .85.sr(),
                                            height: ResponsiveLayout.isDesktop
                                                ? 180.sh()
                                                : 120.sh(),
                                            child: VideoDetails(
                                              isDetailed: false,
                                              showMap: false,
                                              file: selectedFile,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // SizedBox(
            //   height: 54.sr(),
            //   width: 54.sr(),
            //   child: CustomFloatingActionButton(
            //       icon: Videomanager.filter,
            //       onPressed: () async {
            //         CustomOverlayEntry().showLoader();
            //         var fileService = ref.read(fileDetailMiniServiceProvider);
            //         var files = fileService.files.reversed;
            //         List<FileDetailMini> errors =
            //             fileDetailMiniFromJson(storage.read('errors')).toList();

            //         print(errors.length);
            //         var duration = 0;
            //         await Future.forEach<FileDetailMini>(errors,
            //             (element) async {
            //           try {
            //             var oneFile = await fileService.fetchOne(element.id);

            //             var singleDuration = Duration(
            //                     hours: oneFile.info.duration.hour,
            //                     minutes: oneFile.info.duration.minute,
            //                     seconds: oneFile.info.duration.second,
            //                     milliseconds: oneFile.info.duration.millisecond)
            //                 .inMinutes;
            //             print(" single :$singleDuration");
            //             duration += singleDuration;
            //             print("total :$duration");
            //           } catch (e) {
            //             print(e);
            //           }
            //           print("index :${errors.indexOf(element)}");
            //         });

            //         // await Future.forEach<FileDetailMini>(files,
            //         //     (element) async {
            //         //   try {
            //         //     var done = await fileService.fileExists(element.id);
            //         //     if (!done) {
            //         //       errors.add(element);
            //         //       print(false);
            //         //     }
            //         //   } catch (e, s) {
            //         //     errors.add(element);
            //         //     print(false);
            //         //   }
            //         //   print(fileService.files.indexOf(element).toString() +
            //         //       " " +
            //         //       errors.length.toString());
            //         // });
            //         // try {
            //         //   storage.write('errors', fileDetailMiniToJson(errors));
            //         // } catch (e, s) {
            //         //   print("$e $s");
            //         // }

            //         CustomOverlayEntry().closeLoader();
            //       },
            //       roundShape: true,
            //       tooltip: 'Fix'),
            // ),
            SizedBox(
              height: 32.sh(),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Builder(builder: (
                  context,
                ) {
                  final selectedAreaService =
                      ref.watch(selectedAreaServiceProvider);
                  final selectedPoints = selectedAreaService.selectedPoints;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (selectedPoints.isNotEmpty) ...[
                        if (selectedAreaService.refined.value)
                          ClippedHolder(
                            value: selectedAreaService
                                .refinedSelection.value.length,
                            child: SizedBox(
                              child: CustomFloatingActionButton(
                                  roundShape: true,
                                  icon: Videomanager.assign,
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          // debugPrint(selectedPoints.length.toString());
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            titlePadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.zero,
                                            content: AssignManager(
                                              files: selectedAreaService
                                                  .refinedSelection.value,
                                              points: selectedPoints,
                                            ),
                                          );
                                        });
                                    // var fileService =
                                    //     ref.read(fileDetailMiniServiceProvider);
                                    // var listOfFilesToFix = selectedAreaService
                                    //     .refinedSelection.value;

                                    // await fileService
                                    //     .fixLocationData(listOfFilesToFix);
                                    // await fileService
                                    //     .updateLocationDataInServer(
                                    //         listOfFilesToFix);

                                    // await fileService
                                    //     .updateLocationDataInServer(
                                    //         selectedAreaService
                                    //             .refinedSelection.value);

                                    // print(fileService.files[10175].id);

                                    // // await fileService.fixLocationData();
                                    // fileService.updateLocationDataInServer();
                                    // await fileService
                                    //     .updateLocationDataInServer();
                                  },
                                  tooltip: 'Assign Area'),
                            ),
                          ),
                        SizedBox(
                          width: 20.sw(),
                        ),
                        SizedBox(
                          height: 54.sr(),
                          width: 54.sr(),
                          child: CustomFloatingActionButton(
                              icon: Icons.select_all,
                              roundShape: true,
                              onPressed: () async {
                                selectedAreaService.refine();
                              },
                              tooltip: 'Refine/Select'),
                        ),
                        SizedBox(
                          width: 20.sw(),
                        ),
                        SizedBox(
                          height: 54.sr(),
                          width: 54.sr(),
                          child: CustomFloatingActionButton(
                              icon: Videomanager.cleararea,
                              roundShape: true,
                              onPressed: () async {
                                selectedAreaService.clear();
                                setState(() {});
                              },
                              tooltip: 'Clear Selection'),
                        ),
                      ]
                    ],
                  );
                }),
                SizedBox(
                  width: 24.sw(),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 54.sr(),
                      width: 54.sr(),
                      child: CustomFloatingActionButton(
                          icon: Icons.add,
                          onPressed: () async {
                            widget.controller.zoom += ref
                                .read(settingChangeNotifierProvider)
                                .setting
                                .mapSetting
                                .zoom;

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
                              widget.controller.zoom -= ref
                                  .read(settingChangeNotifierProvider)
                                  .setting
                                  .mapSetting
                                  .zoom;
                            });
                          },
                          tooltip: "Zoom out"),
                    ),
                  ],
                )
              ],
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
      heroTag: icon.toString(),
      elevation: 5,
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
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
