import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';

import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/components/analysisMapPainter.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final selectedFileProvider = StateProvider<FileDetailMini?>((ref) {
  return;
});

class AnalysisMapScreen extends ConsumerStatefulWidget {
  final MapController controller;
  final List<FileDetailMini> files;
  final FileDetailMini file;
  AnalysisMapScreen({
    required this.controller,
    required this.files,
    required this.file,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnalysisMapScreenState();
}

class _AnalysisMapScreenState extends ConsumerState<AnalysisMapScreen> {
  final List<Offset> selectedArea = [];

  final GlobalKey _canvasRepaint = GlobalKey();
  void _gotoDefault() {
    // widget.controller.center = widget.controller;
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
        // final fileService = ref.watch(fileDetailMiniServiceProvider);

        return LayoutBuilder(builder: (context, constraint) {
          return MapLayoutBuilder(
            controller: widget.controller,
            builder: (context, transformer) {
              SelectedArea.transformer = transformer;
              try {
                transformer.controller.addListener(() {
                  setState(() {});
                });
              } catch (e) {
                // print(e);
              }

              // transformer.controller.center = LatLng(
              //     fileService.files[10].location.coordinates[0][1],
              //     fileService.files[10].location.coordinates[0][0]);

              // transformer.controller.zoom = 20;

              transformer.controller.addListener(() {
                setState(() {});
              });

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
                    {}
                  },
                  onPointerHover: (details) {},
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      // if (widget.originalData.isEmpty)
                      {
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
                          ClipRRect(
                            child: CustomPaint(
                              painter: AnalaysisMapPainter(
                                  file: widget.file,
                                  files: widget.files,
                                  transfromer: transformer),
                              size:
                                  const Size(double.infinity, double.infinity),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      }),

      // TODO: accrding to design
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
