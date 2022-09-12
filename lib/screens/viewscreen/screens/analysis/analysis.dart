import 'dart:developer';
import 'dart:typed_data';

import 'package:image_compare/image_compare.dart';
import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/components/analysisMap.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'dart:ui' as ui;

import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

enum Matcher { Match, NotSure, NoMatch }

class PreviousAction {
  PreviousAction(
      {this.file1,
      this.file2,
      this.image1,
      this.image2,
      this.match,
      this.file2Index});
  FileDetailMini? file1, file2;
  Uint8List? image1, image2;
  Matcher? match;
  int? file2Index;
}

class PathAnalysis extends StatefulHookConsumerWidget {
  const PathAnalysis(
      {Key? key,
      required this.files,
      required this.file,
      required this.itemBox,
      this.undoWidget,
      this.onMatch,
      this.info,
      this.previousAction,
      this.undo})
      : super(key: key);
  final List<FileDetailMini> files;
  final FileDetailMini file;
  final Rect itemBox;
  final Widget? info;
  final Widget? undoWidget;
  final PreviousAction? previousAction;
  final Function(PreviousAction)? onMatch;
  final Function? undo;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PathAnalysisState();
}

class _PathAnalysisState extends ConsumerState<PathAnalysis> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processFiles = filterFiles();
  }

  final GlobalKey _widgetKey = GlobalKey();
  bool isBusy = false;
  double matchPercentage = 0;
  Uint8List? image1, image2;
  late MapController controller = MapController(
      location: LatLng(widget.file.boundingBox!.center.dx,
          widget.file.boundingBox!.center.dy));
  late Future<List<FileDetailMini>> processFiles;
  Future<List<FileDetailMini>> filterFiles() async {
    List<FileDetailMini> files = [];
    final fileService = ref.read(fileDetailMiniServiceProvider);

    await Future.forEach<FileDetailMini>(widget.files, (element) async {
      if (element.boundingBox!.overlaps(widget.file.boundingBox!)) {
        if (element.originalLocation.isEmpty) {
          List<OriginalLocation> data = [];
          try {
            data = await fileService.fetchOriginalLocation(element.id);
          } catch (e, s) {}

          if (data.isNotEmpty) {
            List<OriginalLocation> newData = [];
            newData.add(data.first);
            for (int i = 1; i < data.length; i++) {
              var e = data[i];
              if (i < data.length - 1) {
                for (int j = i; j < data.length; j++) {
                  var u = data[j];

                  var dist = calculateDistance(
                      LatLng(e.lat, e.lng), LatLng(u.lat, u.lng));

                  if (dist > 1) {
                    i = j;
                    newData.add(u);
                    break;
                  }
                }
              }
            }

            element.originalLocation.addAll(newData);
          }
          if (!files.contains(element)) {
            files.add(element);
          }
        } else {
          if (!files.contains(element)) {
            files.add(element);
          }
        }
      }
      //  else
      // print(element.filename);
    });

    try {
      var filePair = await fileService.findFile(
          visibleFilesList: files, file: widget.file, fileRect: widget.itemBox);

      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          Future.delayed(Duration(milliseconds: 50), () {
            SelectedArea.transformer.controller.zoom += 0.001;
          });
        });
      });
      if (filePair != null) {
        return [widget.file, filePair];
      } else {
        return [widget.file];
      }
    } catch (e, s) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<FileDetailMini>>(
        future: processFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          if (widget.undoWidget != null)
                            Expanded(
                              child: widget.undoWidget!,
                            ),
                          Expanded(
                            key: _widgetKey,
                            flex: 4,
                            child: IgnorePointer(
                              ignoring: widget.info == null ? false : true,
                              child: AnalysisMapScreen(
                                file: widget.file,
                                files: snapshot.data!,
                                controller: controller,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraint) {
                        SelectedArea.transformer.controller
                            .addListener(() async {
                          if (mounted) {
                            if (!isBusy) {
                              isBusy = true;
                              try {
                                image1 = await getImage(snapshot.data!.first);
                              } catch (e) {
                                image1 = Uint8List.fromList([]);
                              }
                              try {
                                image2 = await getImage(snapshot.data!.last);
                              } catch (e) {
                                image2 = Uint8List.fromList([]);
                              }
                              if (widget.onMatch != null) {
                                widget.onMatch!(PreviousAction(
                                  file1: snapshot.data!.first,
                                  file2: snapshot.data!.last,
                                  image1: image1,
                                  image2: image2,
                                ));
                              }
                              // var result = await compareImages(
                              //     src1: image1, src2: image2);
                              // // print(result);
                              // matchPercentage =
                              //     (((result * 1000) - 100)).abs();
                              setState(() {});
                              isBusy = false;
                            }
                          }
                        });
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                Expanded(child: showImage(image1, scale: true)),
                                Container(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Expanded(child: showImage(image2, scale: true))
                              ],
                            ),
                            if (widget.info != null &&
                                image1 != null &&
                                image2 != null)
                              Positioned(
                                top: 0.sh(),
                                left: constraint.maxWidth / 2.9,
                                child: widget.info!,
                              )
                            else
                              Positioned(
                                top: -40,
                                left: constraint.maxWidth / 2 - 70,
                                child: Container(
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.all(12.sr()),
                                    child: Row(
                                      children: [
                                        Text("Match : ",
                                            style: kTextStyleIbmMedium),
                                        image1 == null && image2 == null
                                            ? const SizedBox(
                                                width: 9,
                                                height: 9,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                "${matchPercentage.toStringAsFixed(2)}%",
                                                style: kTextStyleIbmSemiBold
                                                    .copyWith(
                                                        color: Colors.white))
                                      ],
                                    )),
                              ),
                            Positioned(
                              right: constraint.maxWidth / 2 - 90,
                              top: -45,
                              child: Container(
                                color: Colors.white.withOpacity(0.8),
                                child: Text(
                                  "${snapshot.data!.length > 1 ? "Double" : "Single"} File",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 30.ssp()),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ],
                ),
                if (widget.previousAction != null)
                  Align(
                      alignment: Alignment.centerLeft,
                      heightFactor: 1.15,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 250,
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text("Previous: "),
                                  Text(
                                      "${widget.previousAction!.match!.name.toString()}"),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Transform.scale(
                                    scale: 2,
                                    child: showImage(
                                        widget.previousAction!.image1))),
                            Expanded(
                                child: Transform.scale(
                                    scale: 2,
                                    child: showImage(
                                        widget.previousAction!.image2))),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ElevatedButton(
                                  onPressed: widget.undo != null
                                      ? () {
                                          widget.undo!();
                                        }
                                      : null,
                                  child: const Text("Undo")),
                            )
                          ],
                        ),
                      )),

                // Align(
                //     alignment: Alignment.bottomRight,
                //     child: IconButton(
                //       onPressed: () async {
                //         image1 = await getImage(
                //             snapshot.data!.first.originalLocation);
                //         image2 = await getImage(
                //             snapshot.data!.last.originalLocation);

                //         setState(() {});

                //         var result =
                //             await compareImages(src1: image1, src2: image2);
                //         // print(result);
                //         print((((result * 1000) - 100)).abs());
                //       },
                //       icon: const Icon(Videomanager.play_video),
                //     ))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget showImage(Uint8List? img, {bool scale = false}) {
    return img != null
        ? img.isNotEmpty
            ? InteractiveViewer(
                minScale: 0.25,
                maxScale: 2,
                scaleEnabled: scale,
                child: Image.memory(
                  img,
                  fit: BoxFit.contain,
                ),
              )
            : const Icon(Icons.approval_outlined)
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Future<Uint8List> getImage(FileDetailMini file) async {
    List<LatLng> data = [];
    if (file.originalLocation.isEmpty) {
      data = file.location.coordinates
          .map((e) => LatLng(e.last, e.first))
          .toList();
    } else {
      data = file.originalLocation.map((e) => LatLng(e.lat, e.lng)).toList();
    }
    final RenderBox renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    var recorder = ui.PictureRecorder();
    var canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), Offset(size.width, size.height)));
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    Path path = Path();
    path.addPolygon(
        data
            .map((e) => SelectedArea.transformer
                .fromLatLngToXYCoords(LatLng(e.latitude, e.longitude)))
            .toList(),
        false);
    canvas.drawPath(path, paint);
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    var byte = await img.toByteData(format: ui.ImageByteFormat.png);
    return Uint8List.view(byte!.buffer);
  }
}
