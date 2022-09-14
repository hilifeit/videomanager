import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/helper/disk.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/apiHelper.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/users/component/userService.dart';

import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/models/newstate.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';
import 'package:videomanager/screens/viewscreen/models/state.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final fileDetailMiniServiceProvider =
    ChangeNotifierProvider<FileService>((ref) {
  return FileService(ref);
});

class PathAndRect {
  PathAndRect(List<List<double>> data, Rect rect) {
    path = Path();

    path.addPolygon(
        data
            .map((e) => SelectedArea.transformer
                .fromLatLngToXYCoords(LatLng(e.last, e.first)))
            .toList(),
        false);
    box = getRect(rect, SelectedArea.transformer);
  }
  late Path path;
  late Rect box;
}

class FileService extends ChangeNotifier {
  FileService(ChangeNotifierProviderRef<FileService> reff) {
    var userProvider = reff.read(userChangeProvider);
    ref = reff;
    if (userProvider.loggedInUser.value != null) {
      if (userProvider.loggedInUser.value!.role == Roles.superAdmin.index ||
          userProvider.loggedInUser.value!.role == Roles.manager.index) {
        load();
        loadUserData();
      } else {
        userFiles = null;
        loadUserData();
        // filterFile();
      }
    }
  }
  late ChangeNotifierProviderRef<FileService> ref;
  final List<FileDetailMini> files = [];
  final List<CountryState> filesInStates = [];
  // final List<FileDetailMini> selectedVideos = [];
  late List<FileDetailMini>? userFiles;

  final List<AreaModel> areas = [];

  late final selectedFile = Property<FileDetailMini?>(null, notifyListeners);
  // late final selectedUserFileMini = Property<FileDetailMini?>(null, notifyListeners);
  late final selectedUserFile = Property<FileDetail?>(null, notifyListeners);

  load() async {
    CustomOverlayEntry().showLoader();
    await fetchAllArea();
    await fetchAll(fromServer: true);
    await fetchStates();
    notifyListeners();
    CustomOverlayEntry().closeLoader();
    // for (var element in files) {
    //   print(files.indexOf(element));
    //   if (element.originalLocation.isEmpty) {
    //     var originalData = await fetchOriginalLocation(element.id);
    //     if (originalData.isNotEmpty) {
    //       element.originalLocation.addAll(originalData);
    //     }
    //   }
    // }
  }

  loadUserData() async {
    await fetchUserFiles();
  }

  selectUserVideoFile(String id) async {
    selectedUserFile.value = await fetchOne(id);
    // notifyListeners();
  }

  // addSelectedVideoFile(FileDetailMini selectedVideo) {
  //   selectedVideos.add(selectedVideo);
  //   print(selectedVideos.length);
  //   // notifyListeners();
  // }

  selectOrDeselectFile(List<FileDetailMini> filesList, bool selected) {
    for (var element in filesList) {
      var index = files.indexOf(element);
      if (index >= 0) {
        files[index].isSelected = selected;
      }
    }
    notifyListeners();
  }

  // removeSelectedVideoFile(FileDetailMini selectedVideo) {
  //   selectedVideos.remove(selectedVideo);
  //   print(selectedVideos.length);
  //   notifyListeners();
  // }

  fetchUserFiles() async {
    var userProvider = ref.read(userChangeProvider);
    if (userProvider.loggedInUser.value != null) {
      try {
        var response = await client.get(
            Uri.parse(
                "${CustomIP.apiBaseUrl}file/assigned/${userProvider.loggedInUser.value?.id}"),
            headers: {
              "Content-Type": "application/json",
              "x-access-token": userProvider.loggedInUser.value!.accessToken!
            });

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
        var response = await tunnelRequest(() => client.get(
              Uri.parse("${CustomIP.apiBaseUrl}area"),
              headers: {
                "Content-Type": "application/json",
                "x-access-token": userProvider.loggedInUser.value!.accessToken!
              },
            ));
        if (response.statusCode == 200) {
          areas.clear();
          areas.addAll(areaModelFromJson(response.body));

          notifyListeners();
        } else {
          CustomOverlayEntry().closeLoader();
          throw response.statusCode;
        }
      } catch (e, s) {
        CustomOverlayEntry().closeLoader();
        print("$e $s");
        throw e;
      }
    }
  }

  fetchAll({bool fromServer = false}) async {
    if (fromServer) {
      var userProvider = ref.read(userChangeProvider);
      if (userProvider.loggedInUser.value != null) {
        try {
          var response = await tunnelRequest(() =>
              client.get(Uri.parse("${CustomIP.apiBaseUrl}file"), headers: {
                "Content-Type": "application/json",
                "x-access-token": userProvider.loggedInUser.value!.accessToken!
              }));

          if (response.statusCode == 200) {
            files.clear();
            files.addAll(fileDetailMiniFromJson(response.body).toList());

            // List<int> states = [];
            // List<String> district = [];
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

  fetchStates() async {
    try {
      var response = await tunnelRequest(() =>
          client.get(Uri.parse("${CustomIP.apiBaseUrl}boundary"), headers: {
            "Content-Type": "application/json",
          }));
      if (response.statusCode == 200) {
        filesInStates.addAll(countryStatesFromJson(response.body));
        await classifyFiles();
      } else {
        throw response.statusCode;
      }
    } catch (e, s) {
      print("$e $s");
    }
  }

  classifyFiles() async {
    List<PathAndRect> stateBorderData = [];
    for (var e in filesInStates) {
      stateBorderData.add(PathAndRect(e.coordinates, e.boundingBox!));
    }
    await Future.forEach<FileDetailMini>(files, (element) {
      // if (element.isUseable)
      {
        Rect fileMapRect =
            getRect(element.boundingBox!, SelectedArea.transformer);
        for (var e in filesInStates) {
          var index = filesInStates.indexOf(e);
          var stateBorderItem = stateBorderData[index];
          if (fileMapRect.overlaps(stateBorderItem.box)) {
            var first = SelectedArea.transformer.fromLatLngToXYCoords(LatLng(
                element.location.coordinates.first.last,
                element.location.coordinates.first.first));
            var last = SelectedArea.transformer.fromLatLngToXYCoords(LatLng(
                element.location.coordinates.last.last,
                element.location.coordinates.last.first));
            if (stateBorderItem.path.contains(first) &&
                stateBorderItem.path.contains(last)) {
              e.files.add(element);
              break;
              // }
            }
          }
        }
      }
    });
  }

  addOriginalLocation(FileDetailMini file, List<OriginalLocation> data) {
    var index = files.indexOf(file);
    files[index].originalLocation.clear();
    files[index].originalLocation.addAll(data);

    notifyListeners();
  }

  createAreaAndAssign(data) async {
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

  assignVideosToUser(data) async {
    var userProvider = ref.read(userChangeProvider);
    try {
      var response = await client.put(
          Uri.parse("${CustomIP.apiBaseUrl}file/assignFiles"),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "x-access-token": userProvider.loggedInUser.value!.accessToken!
          });
      // print(response.body);
      if (response.statusCode == 200) {
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
      return originalLocation;
    }
  }

  Future<Uint8List?> getFrameFromUrl(
      {required String url, Duration duration = Duration.zero}) async {
    // duration - Duration(milliseconds: 200);
    // print(duration);
    try {
      //00:00:00.000
      //   var url='http://192.168.1.74/';
      // if(!CustomIP.baseUrl.contains('103.'))
      // url=CustomIP.apiBaseUrl;
      var response = await client.get(Uri.parse(
          "${CustomIP.apiBaseUrl}video/image?url=$url&ms=${duration.toString().substring(0, 11)}"));
//       final ByteData imageData = await NetworkAssetBundle(Uri.parse("${CustomIP.apiBaseUrl}video/image?url=$url&ms=$positionInMs")).load("");
// final Uint8List bytes = imageData.buffer.asUint8List();
      if (response.statusCode == 200) {
        // debugPrint(response.body);
        return response.bodyBytes;
      } else {
        var error = jsonDecode(response.body);
        return null;
      }
    } catch (e, s) {
      print("$e $s");

      return null;
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
            print(response.body);
          }
        } catch (e, s) {
          print("$e $s");
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

      //&& index > 6425
      if (element.isUseable) {
        FileDetailMini temp = FileDetailMini(
            id: element.id,
            filename: element.filename,
            location: element.location,
            path: element.path.replaceAll(".MP4", "_processed.json"),
            isUseable: element.isUseable,
            status: element.status,
            isLeft: element.isLeft);

        try {
          var originalData = await fetchOriginalLocation(element.id);
          if (originalData.isNotEmpty) {
            LatLng first =
                LatLng(originalData.first.lat, originalData.first.lng);
            LatLng last = LatLng(originalData.last.lat, originalData.last.lng);
            element.location.coordinates.clear();
            // element.location.coordinates.add([first.longitude,first.latitude]);
            int divider = originalData.length ~/ 50;
            for (int i = 0; i < originalData.length; i = i + divider) {
              element.location.coordinates
                  .add([originalData[i].lng, originalData[i].lat]);
            }
            if (element.location.coordinates.last.first != last.longitude &&
                element.location.coordinates.last.last != last.latitude) {
              element.location.coordinates.add([last.longitude, last.latitude]);
            }
            print(files.indexOf(element));
          }
        } catch (e) {
          print(e.toString() + element.id);
        }
      } else {
        print("not useable");
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

  Future<bool> pairFiles({required String id, required dynamic body}) async {
    var userProvider = ref.read(userChangeProvider);
    try {
      var response =
          await client.put(Uri.parse("${CustomIP.apiBaseUrl}file/pair/$id"),
              headers: {
                "Content-Type": "application/json",
                "x-access-token": userProvider.loggedInUser.value!.accessToken!
              },
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        // var temp = userModelListFromJson(response.body);
        // users = temp;
        // store();
        // notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);
        print(error);
        throw error['message'];
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<bool> deleteArea({required String id}) async {
    var userProvider = ref.read(userChangeProvider);
    try {
      var response = await client.delete(
        Uri.parse("${CustomIP.apiBaseUrl}area/$id"),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": userProvider.loggedInUser.value!.accessToken!
        },
      );

      if (response.statusCode == 200) {
        // var temp = userModelListFromJson(response.body);
        // users = temp;
        // store();
        notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);
        print(error);
        throw error['message'];
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<FileDetailMini?> findFile(
      {required List<FileDetailMini> visibleFilesList,
      required FileDetailMini file,
      required Rect fileRect,
      double minimumDistance = 200}) async {
    loop(List<LatLng> first, List<LatLng> second) {
      List<double> distance = [],
          firstDistanceTotal = [],
          secondDistanceTotal = [];
      var length = first.length < second.length ? first.length : second.length;

      for (int i = 0; i < length; i++) {
        try {
          // var fileElement = first.first;
          // var secondFileElement = second.first;

          var dist = calculateDistance(first[i], second[i]);
          distance.add(dist);
          if (i > 0) {
            firstDistanceTotal.add(calculateDistance(first[i], first[i - 1]));
            secondDistanceTotal
                .add(calculateDistance(second[i], second[i - 1]));
          }
        } catch (e) {}
      }
      double avg = 0, firstTotal = 0, secondTotal = 0;
      for (var element in distance) {
        avg += element;
      }
      for (var element in firstDistanceTotal) {
        firstTotal += element;
      }
      for (var element in secondDistanceTotal) {
        secondTotal += element;
      }
      print(
          "Avg Distance: ${avg / length}m distDiff: ${(firstTotal - secondTotal).abs()} FirstDist: $firstTotal SecondDist: $secondTotal");
      // print(
      //   "Startdiff : ${calculateDistance(LatLng(file.location.coordinates.first.last, file.location.coordinates.first.first), LatLng(distances.first.file.location.coordinates.first.last, distances.first.file.location.coordinates.first.first))}m Enddiff: ${calculateDistance(LatLng(file.location.coordinates.last.last, file.location.coordinates.last.first), LatLng(distances.first.file.location.coordinates.last.last, distances.first.file.location.coordinates.last.first))}m",
      // );
    }

    List<FileWithDistance> distances = [];
    var list = visibleFilesList.toList();

    list.removeWhere((element) => file.isLeft == element.isLeft);
    // print(list.length);
    for (var e in list) {
      Rect testElement = getRect(e.boundingBox!, SelectedArea.transformer);
      // inspect(e.boundingBox);
      double distance = (testElement.center - fileRect.center).distance.abs();
      // inspect(fileRect);
      if (SelectedArea.transformer.controller.zoom < 19) {
        if (distance < minimumDistance) {
          if (e != file) {
            distances.add(FileWithDistance(file: e, distance: distance));
          }
        }
      } else {
        if (e != file) {
          distances.add(FileWithDistance(file: e, distance: distance));
        }
      }
    }
    distances.sort((a, b) => a.distance.compareTo(b.distance));

    if (distances.isNotEmpty) {
      var firstOriginalData = await fetchOriginalLocation(file.id);
      var secondOriginalData =
          await fetchOriginalLocation(distances.first.file.id);

      if (firstOriginalData.isNotEmpty && secondOriginalData.isNotEmpty) {
        print(
            "${firstOriginalData.first.timeStamp} ${firstOriginalData.last.timeStamp}");
        print(
            "${secondOriginalData.first.timeStamp} ${secondOriginalData.last.timeStamp}");

        loop(
            firstOriginalData.map((e) {
              return LatLng(e.lat, e.lng);
            }).toList(),
            secondOriginalData.map((e) => LatLng(e.lat, e.lng)).toList());
        loop(
            file.location.coordinates
                .map((e) => LatLng(e.last, e.first))
                .toList(),
            distances.first.file.location.coordinates
                .map((e) => LatLng(e.last, e.first))
                .toList());
      } else {
        loop(
            file.location.coordinates
                .map((e) => LatLng(e.last, e.first))
                .toList(),
            distances.first.file.location.coordinates
                .map((e) => LatLng(e.last, e.first))
                .toList());
      }

      print(file.boundingBox!.overlaps(distances.first.file.boundingBox!));

      return distances.first.file;
    } else {
      return null;
    }
  }
}
