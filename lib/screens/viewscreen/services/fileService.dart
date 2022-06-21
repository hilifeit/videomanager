import 'dart:math';

import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

final fileDetailMiniServiceProvider =
    ChangeNotifierProvider<FileService>((ref) {
  return FileService();
});

class FileService extends ChangeNotifier {
  FileService() {
    load();
  }
  List<FileDetailMini> files = [];

  load() async {
    await fetch();
    // print(files.length);
  }

  fetch() async {
    try {
      var response = await client.get(Uri.parse("${baseURL}file"),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        files = fileDetailMiniFromJson(response.body).toList();
        await Future.forEach<FileDetailMini>(files, (element) {
          element.boundingBox = boundingBoxOffset(element.location.coordinates);
        });

        // print(
        //     "${files[0].boundingBox!.left.toString()} ${files[0].boundingBox!.top.toString()}");
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw "$e";
    }
  }

  Rect boundingBoxOffset(List<List<double>> list) {
    double minX = double.infinity;
    double maxX = 0;
    double minY = double.infinity;
    double maxY = 0;
    for (int i = 0; i < list.length; i++) {
      minX = min(minX, list[i].last);
      minY = min(minY, list[i].first);
      maxX = max(maxX, list[i].last);
      maxY = max(maxY, list[i].first);
    }

    //var space = 5;
    var rec = Rect.fromLTWH(minX, minY, (maxX - minX), (maxY - minY));

    //print(rec);
    return rec;
  }
}
