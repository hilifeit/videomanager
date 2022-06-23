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
        List<int> states = [];
        List<String> district = [];
        await Future.forEach<FileDetailMini>(files, (element) {
          element.boundingBox = boundingBoxOffset(element.location.coordinates);
          // if (!states.contains(element.area.state)) {
          //   states.add(element.area.state);
          // }
          // if (!states.contains(element.area.state)) {
          //   states.add(element.area.state);
          // }
        });

        // print(
        //     "${files[0].boundingBox!.left.toString()} ${files[0].boundingBox!.top.toString()}");
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e, s) {
      throw "$e $s";
    }
  }

  updateOneFileUsable(FileDetailMini file, bool value) {
    files[files.indexOf(file)].isUseable = value;
    notifyListeners();
  }

  Future<bool> edit(FileDetailMini file, {dynamic data}) async {
    try {
      var response = await client.put(Uri.parse("${baseURL}file/${file.id}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        // var temp = userModelListFromJson(response.body);
        // users = temp;
        // store();

        // notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);

        throw error['message'];
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
