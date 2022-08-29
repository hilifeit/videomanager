import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/singlePathPainter.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/services/dualvideo.dart';

class SinglePath extends StatefulWidget {
  SinglePath(
      {Key? key,
      required this.data,
      required this.transformer,
      this.isFirst = true})
      : super(key: key);
  final List<OriginalLocation> data;
  final MapTransformer transformer;
  final bool isFirst;
  @override
  State<SinglePath> createState() => _SinglePathState();
}

class _SinglePathState extends State<SinglePath> {
  Duration currentPosition = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.transformer.controller.center =
        LatLng(widget.data.first.lat, widget.data.first.lng);

    var countTrue = 0, countFalse = 0;
    for (var element in widget.data) {
      if (element.duplicate)
        countFalse++;
      else
        countTrue++;
    }
    if (widget.isFirst) print("$countTrue $countFalse ${widget.data.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: SinglePathPainter(
                transformer: widget.transformer, data: widget.data),
          ),
        ),
        Consumer(builder: (context, ref, c) {
          if (UniversalPlatform.isDesktop) {
            final videoService = widget.isFirst
                ? ref.watch(dualVideoServiceProvider).desktop1.value
                : ref.watch(dualVideoServiceProvider).desktop2.value;

            return videoService != null
                ? StreamBuilder<PositionState>(
                    stream: widget.isFirst
                        ? videoService.player.positionStream
                        : videoService.player.positionStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final index = map(
                            snapshot.data!.position!.inMilliseconds,
                            0,
                            videoService.duration.inMilliseconds,
                            0,
                            widget.data.length);
                        final offset = widget.transformer.fromLatLngToXYCoords(
                            LatLng(widget.data[index].lat,
                                widget.data[index].lng));
                        return markerWidget(offset);
                      }
                      return Container();
                    })
                : Container();
          } else {
            final videoService = widget.isFirst
                ? ref.watch(dualVideoServiceProvider).web1.value
                : ref.watch(dualVideoServiceProvider).web2.value;
            return videoService != null
                ? ValueListenableBuilder<VideoPlayerValue>(
                    valueListenable: videoService,
                    builder: (context, value, child) {
                      var index;
                      try {
                        index = map(
                            value.position.inMilliseconds,
                            0,
                            value.duration.inMilliseconds,
                            0,
                            widget.data.length);
                      } catch (e) {
                        index = 0;
                      }

                      final offset = widget.transformer.fromLatLngToXYCoords(
                          LatLng(
                              widget.data[index].lat, widget.data[index].lng));
                      return markerWidget(offset);

                      // return Container();
                    })
                : Container();
          }
        })
      ],
    );
  }

  Widget markerWidget(Offset offset) {
    final size = 8.sr();
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: offset.dx - (size / 2),
      top: offset.dy - (size / 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        height: size,
        width: size,
      ),
    );
  }
}
