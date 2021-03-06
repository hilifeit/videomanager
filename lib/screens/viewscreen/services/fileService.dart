import 'dart:math';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/helper/disk.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final fileDetailMiniServiceProvider =
    ChangeNotifierProvider<FileService>((ref) {
  return FileService(ref);
});

class FileService extends ChangeNotifier {
  FileService(ChangeNotifierProviderRef<FileService> reff) {
    var userProvider = reff.read(userChangeProvider);
    ref = reff;
    if (userProvider.loggedInUser.value != null) {
      if (userProvider.loggedInUser.value!.role == Roles.superAdmin.index) {
        load();
      } else {
        userFiles = null;
        loadUserData();
        // filterFile();
      }
    }
  }
  late ChangeNotifierProviderRef<FileService> ref;
  final List<FileDetailMini> files = [];
  late List<FileDetailMini>? userFiles;

  final List<AreaModel> areas = [];

  late final selectedFile = Property<FileDetailMini?>(null, notifyListeners);
  // late final selectedUserFileMini = Property<FileDetailMini?>(null, notifyListeners);
  late final selectedUserFile = Property<FileDetail?>(null, notifyListeners);

  load() async {
    CustomOverlayEntry().showLoader();
    await fetchAllArea();
    await fetchAll(fromServer: true);
    CustomOverlayEntry().closeLoader();
  }

  loadUserData() async {
    await fetchUserFiles();
  }

  selectUserVideoFile(String id) async {
    selectedUserFile.value = await fetchOne(id);
    notifyListeners();
  }

  fetchUserFiles() async {
    var userProvider = ref.read(userChangeProvider);
    if (userProvider.loggedInUser.value != null) {
      try {
        var response = await client.get(
            Uri.parse(
                "${CustomIP.apiBaseUrl}file/assigned/${userProvider.loggedInUser.value?.id}"),
            headers: {"Content-Type": "application/json"});

        if (response.statusCode == 200) {
          // userFiles = [];

          userFiles = fileDetailMiniFromJson(response.body).toList();
          if (userFiles!.isNotEmpty) {
            selectedUserFile.value = await fetchOne(userFiles!.first.id);
            notifyListeners();
          }
        } else {
          var error = jsonDecode(response.body);

          throw error['message'];
        }
      } catch (e, s) {
        throw "$e $s";
      }
    }
  }

  Future<FileDetail> fetchOne(String id) async {
    try {
      var response = await client.get(
          Uri.parse("${CustomIP.apiBaseUrl}file/$id"),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        return fileDetailFromJson(response.body);
      } else {
        var error = jsonDecode(response.body);

        throw error['message'];
      }
    } catch (e) {
      throw "$e";
    }
  }

  fetchAllArea() async {
    var userProvider = ref.read(userChangeProvider);
    if (userProvider.loggedInUser.value != null) {
      try {
        var response = await client.get(
          Uri.parse("${CustomIP.apiBaseUrl}area"),
          headers: {
            "Content-Type": "application/json",
            "x-access-token": userProvider.loggedInUser.value!.accessToken!
          },
        );
        if (response.statusCode == 200) {
          areas.clear();
          areas.addAll(areaModelFromJson(response.body));
          notifyListeners();
        } else {
          throw response.statusCode;
        }
      } catch (e, s) {
        print("$e $s");
        throw e;
      }
    }
  }

  fetchAll({bool fromServer = false}) async {
    if (fromServer) {
      try {
        var response = await client.get(Uri.parse("${CustomIP.apiBaseUrl}file"),
            headers: {"Content-Type": "application/json"});

        if (response.statusCode == 200) {
          files.clear();
          files.addAll(fileDetailMiniFromJson(response.body).toList());

          List<int> states = [];
          List<String> district = [];
          await Future.forEach<FileDetailMini>(files, (element) {
            element.boundingBox =
                boundingBoxOffset(element.location.coordinates);
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
    } else {
      var filesJson = await storage.read("files");
      if (filesJson != null) {
        files.clear();

        files.addAll(fileDetailMiniFromJson(filesJson).toList());
        await Future.forEach<FileDetailMini>(files, (element) {
          element.boundingBox = boundingBoxOffset(element.location.coordinates);
          // if (!states.contains(element.area.state)) {
          //   states.add(element.area.state);
          // }
          // if (!states.contains(element.area.state)) {
          //   states.add(element.area.state);
          // }
        });
      } else {
        await fetchAll(fromServer: true);
      }
    }
  }

  addOriginalLocation(FileDetailMini file, List<OriginalLocation> data) {
    var index = files.indexOf(file);
    files[index].originalLocation.clear();
    files[index].originalLocation.addAll(data);

    notifyListeners();
  }

  createAreaAndAssign(Map data) async {
    var userProvider = ref.read(userChangeProvider);
    try {
      var response = await client.post(Uri.parse("${CustomIP.apiBaseUrl}area"),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "x-access-token": userProvider.loggedInUser.value!.accessToken!
          });
      // print(response.body);
      if (response.statusCode == 201) {
        // areas.add(AreaModel.fromJson(jsonDecode(response.body)));
        notifyListeners();
      } else {
        var error = jsonDecode(response.body);
        throw error("message");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OriginalLocation>> fetchOriginalLocation(String id) async {
    final List<OriginalLocation> originalLocation = [];
    try {
      var response = await client
          .get(Uri.parse("${CustomIP.apiBaseUrl}video/$id?json=true"));
      // print(response.body);
      if (response.statusCode == 200) {
        originalLocation.addAll(originalLocationFromJson(response.body));
        return originalLocation;
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> fileExists(String id) async {
    try {
      var response =
          await client.head(Uri.parse("${CustomIP.apiBaseUrl}video/$id"));
      // print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      snack.error(e);
      rethrow;
    }
  }

  updateOneFileUsable(FileDetailMini file, bool value) {
    files[files.indexOf(file)].isUseable = value;
    notifyListeners();
  }

  Future<bool> edit(FileDetailMini file, {dynamic data}) async {
    try {
      var response = await client.put(
          Uri.parse("${CustomIP.apiBaseUrl}file/${file.id}"),
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

  Future<String> getUrlFromFile(FileDetailMini file) async {
    var paths = file.path.replaceAll("\\", "/").split("/");

    var usebalepaths = paths.getRange(2, paths.length);
    String filePath = usebalepaths.join("/");
    String urlFound = '';
    bool found = false;

    await Future.forEach<Hdd>(Hdd.values, (element) async {
      final setting =
          CustomKeys().ref!.watch(settingChangeNotifierProvider).setting;
      String url = "${setting.videoSetting.videourl}/${element.name}/$filePath";
      if (!found) {
        try {
          var response = await client.head(Uri.parse(url));

          if (response.statusCode == 200) {
            {
              found = true;
              urlFound = url;
            }
          } else {
            // print(response.statusCode);
          }
        } catch (e) {
          // snack.error(e.toString());
        }
      }
    });

    return Future.value(urlFound);
  }

  fixLocationData(List<FileDetailMini>? selectedFiles) async {
    var list = selectedFiles ?? files;
    for (var element in list) {
      var index = files.indexOf(element);
      if (element.isUseable && index > 6425) {
        FileDetailMini temp = FileDetailMini(
            id: element.id,
            filename: element.filename,
            location: element.location,
            path: element.path.replaceAll(".MP4", "_processed.json"),
            isUseable: element.isUseable,
            status: element.status);

        var url = await getUrlFromFile(temp);
        if (url.isNotEmpty) {
          try {
            var originalData = await fetchOriginalLocation(url);
            if (originalData.isNotEmpty) {
              LatLng first =
                  LatLng(originalData.first.lat, originalData.first.lng);
              LatLng last =
                  LatLng(originalData.last.lat, originalData.last.lng);
              element.location.coordinates.clear();
              // element.location.coordinates.add([first.longitude,first.latitude]);
              int divider = originalData.length ~/ 50;
              for (int i = 0; i < originalData.length; i = i + divider) {
                element.location.coordinates
                    .add([originalData[i].lng, originalData[i].lat]);
              }
              if (element.location.coordinates.last.first != last.longitude &&
                  element.location.coordinates.last.last != last.latitude) {
                element.location.coordinates
                    .add([last.longitude, last.latitude]);
              }
              print(files.indexOf(element));
            }
          } catch (e) {
            print(e.toString() + element.id);
          }
        } else {
          print("empty${files.indexOf(element)}");
        }
      }
    }
  }

  updateLocationDataInServer(List<FileDetailMini>? selectedFiles) async {
    for (var element in selectedFiles ?? files) {
      // storage.write("files", fileDetailMiniToJson(files));
      // File file = File("D:\\Projects\\file.json");
      // file.writeAsStringSync(storage.read("files"));
      // var element = files.first;

      try {
        var elementJson = element.toJson();
        // if (element.id == "6299bd5a4d73c7e1d6e0fbc9")
        {
          var status = await edit(element, data: {
            "location": {
              "type": "LineString",
              "coordinates": elementJson["location"]["coordinates"]
            }
          });
          print("$status ${files.indexOf(element)} ${element.id}");
        }
      } catch (e) {
        print("$e ${files.indexOf(element)} ${element.id}");
      }
    }
  }
}
