import 'dart:io';
import 'dart:typed_data';

import 'package:image_compare/image_compare.dart';
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

  final List<Paths> paths = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // paths.addAll(getPathsFromOriginalData(widget.data, widget.transformer));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: SinglePathPainter(
                transformer: widget.transformer,
                data: widget.data,
                paths: paths,
                getImage: (image) async {
                  final img = Uint8List.view(image.buffer);

                  // var result = await compareImages(src1: img, src2: Image(image: image));
                }),
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

  List<Paths> getPathsFromOriginalData(
      List<OriginalLocation> data, MapTransformer transformer) {
    List<Offset> noDuplicatePath = [];

    List<Offset> duplicatePath = [];

    Path path = Path();

    List<Paths> paths = [];

    for (var element in data) {
      if (!element.duplicate) {
        var index = data.indexOf(element);

        if (index != 0) {
          if (data[index - 1].duplicate) {
            path.addPolygon(duplicatePath, true);
            paths.add(Paths(paths: path, duplicate: true));
            // count += duplicatePath.length;
            duplicatePath.clear();
            path.reset();
          }
        }

        var offset =
            transformer.fromLatLngToXYCoords(LatLng(element.lat, element.lng));
        noDuplicatePath.add(offset);
      } else {
        var index = data.indexOf(element);

        if (index != 0) {
          if (!data[index - 1].duplicate) {
            path.addPolygon(noDuplicatePath, false);
            paths.add(Paths(paths: path, duplicate: false));
            // count += noDuplicatePath.length;
            noDuplicatePath.clear();
            path.reset();
          }
        }

        var offset =
            transformer.fromLatLngToXYCoords(LatLng(element.lat, element.lng));
        duplicatePath.add(offset);
      }
    }
    if (noDuplicatePath.isNotEmpty) {
      path.addPolygon(noDuplicatePath, false);
      paths.add(Paths(paths: path, duplicate: false));
      // count += noDuplicatePath.length;
    }
    if (duplicatePath.isNotEmpty) {
      path.addPolygon(duplicatePath, true);
      paths.add(Paths(paths: path, duplicate: true));
      // count += duplicatePath.length;
    }

    noDuplicatePath.clear();
    duplicatePath.clear();
    return paths;
  }

  Widget markerWidget(Offset offset) {
    final size = 10.sr();
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: offset.dx - (size / 2),
      top: offset.dy - (size / 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        height: size,
        width: size,
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
