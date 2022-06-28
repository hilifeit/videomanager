// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:map/map.dart';
import 'package:touchable/touchable.dart';
import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/video/video.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/filterService.dart';

class FileWithDistance {
  FileWithDistance({required this.file, required this.distance});
  final FileDetailMini file;
  final double distance;
}

class Painter extends CustomPainter {
  Painter(this.context, this.ref,
      {required this.transformer, required this.selectedFileProvider});
  // List<GeoFile> data;
  // int currentIndex, selectedIndex;
  // int sample;
  final BuildContext context;
  final WidgetRef ref;
  final StateProvider<FileDetailMini?> selectedFileProvider;
  bool debug = true;
  MapTransformer transformer;

  @override
  void paint(Canvas canvas, size) {
    // DateTime start = DateTime.now();
    var sampler = map(transformer.controller.zoom.toInt(), 17, 20, 1, 5);
    sampler = 6 - sampler;

    final fileservice = ref.watch(fileDetailMiniServiceProvider);
    final selectedFile = ref.watch(selectedFileProvider);
    final filterService = ref.watch(filterServiceProvider);
    final settingService = ref.watch(settingChangeNotifierProvider);
    final files = fileservice.files;
    final stroke = settingService.setting.mapSetting.stroke.toDouble();
    var paint = Paint()..style = PaintingStyle.fill;
    var rpaint = Paint()..style = PaintingStyle.fill;
    rpaint.style = PaintingStyle.fill;
    rpaint.color = Colors.red.withOpacity(0.01);

    paint.style = PaintingStyle.stroke;

    paint.strokeWidth = stroke;

    var customCanvas = TouchyCanvas(context, canvas);
    Rect visibleScreen = Rect.fromLTWH(0, 0, transformer.constraints.maxWidth,
        transformer.constraints.maxHeight - 5);

    var visibleFiles = 0, totalDataUsedForPaint = 0, sampleLength = 0;

    List<FileDetailMini> visibleFilesList = [];
    for (var element in files) {
      Rect item = getRect(element.boundingBox!);
      if (item.overlaps(visibleScreen)) {
        visibleFilesList.add(element);
      }
    }
    if (files.isNotEmpty) {
      if (!filterService.onlyNotUsable) {
        if (kIsWeb) {
          sampleLength = map(
              files.length - visibleFilesList.length, 0, files.length, 0, 20);
        } else {
          sampleLength = map(
              files.length - visibleFilesList.length, 0, files.length, 0, 49);
        }
      } else {
        sampleLength = 50;
      }
    }

    for (var element in visibleFilesList) {
      if (filterService.onlyNotUsable == !element.isUseable) {
        visibleFiles++;
        Path path = Path();
        Rect item = getRect(element.boundingBox!);
        Function tap, tapSecondary;
        tap = () {
          ref.read(selectedFileProvider.state).state = element;
        };
        tapSecondary = (TapUpDetails detail) {
          tap();

          showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                  detail.globalPosition.dx,
                  detail.globalPosition.dy,
                  detail.globalPosition.dx + 1,
                  detail.globalPosition.dy + 1),
              items: [
                PopupMenuItem(
                  child: CustomPopUpMenuItemChild(
                    icon: Videomanager.assign,
                    text: "Assign Video",
                  ),
                  onTap: () async {
                    // Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 10), () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              titlePadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              content: AssignUser(
                                fileDetail: element,
                              ),
                            );
                          });
                    });
                  },
                ),
                PopupMenuItem(
                    onTap: () async {
                      var firstVideoUrl =
                          await fileservice.getUrlFromFile(element);
                      print(firstVideoUrl);
                      if (firstVideoUrl.isNotEmpty) {
                        FileDetailMini? secondVideo = findFile(
                            visibleFilesList: visibleFilesList,
                            file: element,
                            fileRect: item);
                        var secondVideoUrl = firstVideoUrl;
                        if (secondVideo != null) {
                          await fileservice.getUrlFromFile(secondVideo);
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Video(
                                  pathLeft: firstVideoUrl,
                                  pathRight: secondVideoUrl,
                                );
                              });
                        } else {
                          await snack.info("Adjacent Video not found");
                          Future.delayed(const Duration(milliseconds: 800), () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Video(
                                    pathLeft: firstVideoUrl,
                                    pathRight: secondVideoUrl,
                                  );
                                });
                          });
                        }
                      } else {
                        snack.error("Video not found!");
                      }
                    },
                    child: CustomPopUpMenuItemChild(
                      icon: Videomanager.play_video,
                      text: "Play Video",
                      width: 137.sw(),
                    )),
                PopupMenuItem(
                    onTap: () async {
                      final fileminiService =
                          ref.read(fileDetailMiniServiceProvider);

                      try {
                        if (await fileminiService.edit(element,
                            data: {"useable": !element.isUseable})) {
                          fileminiService.updateOneFileUsable(
                              element, !element.isUseable);
                          ref.read(selectedFileProvider.state).state = null;
                          snack.success("Status Updated Succesfully");
                        }
                      } catch (e) {
                        snack.error(e.toString());
                      }
                    },
                    child: CustomPopUpMenuItemChild(
                      icon: element.isUseable
                          ? Videomanager.close
                          : Videomanager.sucess,
                      text: element.isUseable ? "Damaged" : "Fixed",
                      width: 137.sw(),
                    )

                    // Text("Flag ${element.isUseable ? "Damaged" : "Fixed"}")
                    )
              ]);
        };

        List<Offset> points = [];
        Offset start = transformer.fromLatLngToXYCoords(LatLng(
            element.location.coordinates.first.last,
            element.location.coordinates.first.first));
        points.add(start);
        if (sampleLength != 0) {
          for (int i = 1;
              i < element.location.coordinates.length;
              i = i + (50 ~/ sampleLength)) {
            // print('$i');
            // if (i < sampleLength - 1) {

            Offset current = transformer.fromLatLngToXYCoords(LatLng(
                element.location.coordinates[i].last,
                element.location.coordinates[i].first));
            points.add(current);

            // }
          }
        }

        Offset end = transformer.fromLatLngToXYCoords(LatLng(
            element.location.coordinates.last.last,
            element.location.coordinates.last.first));
        points.add(end);
        totalDataUsedForPaint += points.length;
        paint.strokeWidth = stroke;
        paint.style = PaintingStyle.stroke;
        paint.color = element.isUseable ? Colors.red : Colors.black;

        path.addPolygon(points, false);
        Paint newPaint = Paint()
          ..color = Theme.of(context).primaryColor.withOpacity(0.1);

        {
          customCanvas.drawPath(path, paint, onTapUp: (details) {
            tap();
          }, onSecondaryTapUp: (detail) {
            tapSecondary(detail);
          });
        }

        if (selectedFile != null) {
          if (selectedFile.id == element.id) {
            paint.strokeWidth = stroke * 2;
            paint.color = Theme.of(context).primaryColor;
            customCanvas.drawPath(path, paint, onTapUp: (details) {
              tap();
            }, onSecondaryTapUp: (detail) {});
            paint.color = Colors.red;
            paint.strokeWidth = stroke;
            customCanvas.drawPath(path, paint, onTapUp: (details) {
              // tap();
            }, onSecondaryTapUp: (detail) {
              tapSecondary(detail);
            });

            newPaint.style = PaintingStyle.stroke;
            newPaint.color = Theme.of(context).primaryColor;
            customCanvas.drawRect(path.getBounds(), newPaint,
                onTapUp: ((details) {
              tap();
            }), onSecondaryTapUp: (detail) {
              tapSecondary(detail);
            });
            newPaint.style = PaintingStyle.fill;
            newPaint.color = Colors.transparent;
            customCanvas.drawRect(item, newPaint, onTapUp: ((details) {
              tap();
            }), onSecondaryTapUp: (detail) {
              tapSecondary(detail);
            });
          } else {
            if (filterService.onlyNotUsable == !element.isUseable) {
              customCanvas.drawRect(item, newPaint, onTapUp: ((details) {
                tap();
              }), onSecondaryTapUp: (detail) {
                tapSecondary(detail);
              });
            }
          }
        } else {
          if (filterService.onlyNotUsable == !element.isUseable) {
            customCanvas.drawRect(path.getBounds(), newPaint,
                onTapUp: ((details) {
              tap();
            }), onSecondaryTapUp: (detail) {
              tapSecondary(detail);
            });
          }
        }
        // path.close();

      }
    }

    if (debug && files.isNotEmpty) {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, 40),
          paint
            ..color = Colors.white.withOpacity(0.8)
            ..style = PaintingStyle.fill);
      drawText(canvas,
          text:
              "Debug Window~     Files: ${files.length}    Visible: $visibleFiles    Visible Samples: $totalDataUsedForPaint Samples Used:$sampleLength",
          position: const Offset(10, 10));
    }
    // print(DateTime.now().difference(start).inMilliseconds);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  FileDetailMini? findFile(
      {required List<FileDetailMini> visibleFilesList,
      required FileDetailMini file,
      required Rect fileRect,
      double minimumDistance = 50}) {
    List<FileWithDistance> distances = [];
    for (var e in visibleFilesList) {
      Rect testElement = getRect(e.boundingBox!);
      double distance = (testElement.center - fileRect.center).distance.abs();

      if (distance < minimumDistance) {
        if (e != file) {
          distances.add(FileWithDistance(file: e, distance: distance));
        }
      }
    }
    distances.sort((a, b) => a.distance.compareTo(b.distance));
    return distances.isNotEmpty ? distances.first.file : null;
  }

  Rect getRect(Rect boundingBox) {
    Offset topLeft = transformer.fromLatLngToXYCoords(
        LatLng(boundingBox.topLeft.dx, boundingBox.topLeft.dy));
    Offset topRight = transformer.fromLatLngToXYCoords(
        LatLng(boundingBox.topRight.dx, boundingBox.topRight.dy));
    Offset bottomLeft = transformer.fromLatLngToXYCoords(
        LatLng(boundingBox.bottomLeft.dx, boundingBox.bottomLeft.dy));

    var height = (topLeft - topRight).distance;
    var width = (topLeft - bottomLeft).distance;

    return Rect.fromCenter(
        center: transformer.fromLatLngToXYCoords(
            LatLng(boundingBox.center.dx, boundingBox.center.dy)),
        width: width,
        height: height);
  }

  double indicativeAngle(List<Offset> points) {
    Offset c = centroid(points);
    return atan2(c.dy - points[0].dy, c.dx - points[0].dx);
  }

  Offset centroid(List<Offset> points) {
    double x = 0;
    double y = 0;
    for (int i = 0; i < points.length; i++) {
      x += points[i].dx;
      y += points[i].dy;
    }
    x = x / points.length;
    y = y / points.length;

    return Offset(x, y);
  }

  drawText(canvas, {required String text, required Offset position}) {
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.red, fontSize: 16.ssp()), text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, position);
  }
}
