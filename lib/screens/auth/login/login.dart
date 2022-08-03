import 'dart:io';

import 'package:videomanager/screens/auth/auth.dart';
import 'package:videomanager/screens/load.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

final passwordvisibileProvider = StateProvider<bool>((ref) {
  return true;
});
final checkBoxStateProvider = StateProvider<bool>((ref) {
  return true;
});

class Login extends ConsumerWidget {
  Login({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '', password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checked = ref.watch(checkBoxStateProvider.state).state;
    // final userService = ref.watch(userChangeProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sr()),
        color: whiteColor,
      ),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 98.sh(),
                    ),
                    Text(
                      'LOGIN WITH',
                      style: kTextStyleIbmMedium.copyWith(
                        fontSize: 25.ssp(),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 17.sh(),
                    ),
                    Text(
                      'EZSALES',
                      style: kTextStyleIbmMedium.copyWith(
                        fontSize: 25.ssp(),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 93.sh(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        !ResponsiveLayout.isMobile ? 105.sw(min: 70) : 25.sw()),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputTextField(
                        value: username,
                        isVisible: true,
                        title: 'USERNAME',
                        validator: (val) => validateUserName(val!),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                      SizedBox(
                        height: 25.5.sh(),
                      ),
                      InputTextField(
                        value: password,
                        isVisible: true,
                        title: 'PASSWORD',
                        validator: (val) => validatePassword(val!),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 25.5.sh(),
                      ),
                      CustomElevatedButton(
                          width: double.infinity,
                          onPressedElevated: () async {
                            final userService = ref.read(userChangeProvider);

                            if (formKey.currentState!.validate()) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: SizedBox(
                                        // color: Colors.teal,
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    );
                                  });
                              try {
                                await userService.login(
                                  remember: checked,
                                  username: username,
                                  password: password,
                                );

                                snack.success("Login Succesful");
                                ref.read(loginStateProvider.state).state =
                                    false;

                                Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () async {
                                  await userService.fetchAll();
                                  customSocket.connect();
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              } catch (e) {
                                Navigator.pop(context);
                                snack.error(e);
                              }
                            }
                          },
                          elevatedButtonText: 'Login'),
                      // Button(
                      //   onPressed: () async {
                      //     final userService = ref.read(userChangeProvider);

                      //     if (formKey.currentState!.validate()) {
                      //       showDialog(
                      //           barrierDismissible: false,
                      //           context: context,
                      //           builder: (context) {
                      //             return const Center(
                      //               child: SizedBox(
                      //                 // color: Colors.teal,
                      //                 height: 50,
                      //                 width: 50,
                      //                 child: Center(
                      //                     child: CircularProgressIndicator()),
                      //               ),
                      //             );
                      //           });
                      //       try {
                      //         await userService.login(
                      //           remember: checked,
                      //           username: username,
                      //           password: password,
                      //         );

                      //         snack.success("Login Succesful");
                      //         ref.read(loginStateProvider.state).state = false;

                      //         Future.delayed(const Duration(milliseconds: 100),
                      //             () async {
                      //           await userService.fetchAll();
                      //           customSocket.connect();
                      //         });
                      //         // ignore: use_build_context_synchronously
                      //         Navigator.pop(context);
                      //       } catch (e) {
                      //         Navigator.pop(context);
                      //         snack.error(e);
                      //       }
                      //     }

                      //     //populateDirectories(context, ref, single: false);
                      //   },
                      //   label: 'Login',
                      //   kLabelTextStyle: kTextStyleIbmMedium.copyWith(
                      //     color: Colors.white,
                      //   ),
                      // ),
                      SizedBox(
                        height: 22.sh(),
                      ),
                      OverflowBar(
                        // runAlignment: WrapAlignment.spaceBetween,
                        alignment: MainAxisAlignment.spaceBetween,
                        overflowAlignment: OverflowBarAlignment.center,
                        overflowSpacing: 10.sh(),
                        children: [
                          Wrap(
                            // runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Consumer(builder: (context, ref, c) {
                                return Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    side: BorderSide(
                                      width: 1.sw(),
                                      color: secondaryColorText,
                                    ),
                                    activeColor: primaryColor,
                                    value: checked,
                                    onChanged: (value) {
                                      ref
                                          .read(checkBoxStateProvider.state)
                                          .state = value!;
                                    });
                              }),
                              GestureDetector(
                                onTap: () => ref
                                    .read(checkBoxStateProvider.state)
                                    .state = !checked,
                                child: Text(
                                  'Stay logged in?',
                                  style: kTextStyleIbmMedium,
                                ),
                              ),
                            ],
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Consumer(builder: (context, ref, c) {
                              return GestureDetector(
                                onTap: () {
                                  ref.read(authStateProvider.state).state =
                                      false;
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: kTextStyleIbmRegular,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sh(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  populateDirectories(BuildContext context, WidgetRef ref,
      {bool single = true}) async {
    String? selectedDirectory;
    if (single) {
      selectedDirectory = await FilePicker.platform.getDirectoryPath();
    }

    if (single && selectedDirectory == null) {
      // User canceled the picker

    } else {
      List<String> finalDrives = [];
      if (!single) {}

      final List<FileSystemEntity> entities = [];
      if (single) {
        entities.addAll(
            await Directory(selectedDirectory!).list(recursive: true).toList());
      } else {
        await Future.forEach<String>(finalDrives, (element) async {
          entities
              .addAll(await Directory(element).list(recursive: true).toList());
        });
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          //barrierColor: Colors.black,
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  height: 20.sh(),
                ),
                Text("Filtering from ${entities.length} files")
              ],
            );
          });
      // entities.forEach((element) {
      //   print(element);
      // });
      // final List<FileThumb> files = [];
      // final Iterable<File> iterablefiles = entities.whereType<File>();
      // ignore: avoid_function_literals_in_foreach_calls

      //   FolderStructure tempData =
      //       FolderStructure(states: [], places: [], riders: []);
      //   await Future.forEach<File>(iterablefiles, (element) async {
      //     List<String> path = element.path.split('\\');
      //     List<String> fixedPath = [];
      //     await Future.forEach<String>(path, (element) {
      //       if (element.toLowerCase() == "nepal") {
      //         fixedPath.addAll(path.skip(path.indexOf(element) - 1));
      //       }
      //     });
      //     if (fixedPath.isNotEmpty) {
      //       var state = int.tryParse(fixedPath[2].characters.last);
      //       if (!tempData.states.contains(state)) {
      //         if (state != null) tempData.states.add(state);
      //       }
      //       try {
      //         Place place = tempData.places.singleWhere(
      //           (element) =>
      //               element.name.toLowerCase() ==
      //               fixedPath[3].toLowerCase().trim(),
      //         );
      //       } catch (e, s) {
      //         Place finalPlace = Place(
      //             name: fixedPath[3].toLowerCase().trim(),
      //             areas: [],
      //             rider: fixedPath[0].toLowerCase().trim(),
      //             state: state!);
      //         tempData.places.add(finalPlace);
      //       }
      //       int placeIndex = tempData.places.indexWhere((element) =>
      //           element.name.toLowerCase() == fixedPath[3].toLowerCase().trim());

      //       try {
      //         Area area = tempData.places[placeIndex].areas.singleWhere(
      //           (element) =>
      //               element.name.toLowerCase().trim() ==
      //               fixedPath[4].toLowerCase().trim(),
      //         );
      //       } catch (e, s) {
      //         Area finalarea =
      //             Area(name: fixedPath[4].toLowerCase().trim(), days: []);
      //         tempData.places[placeIndex].areas.add(finalarea);
      //       }
      //       int areaIndex = tempData.places[placeIndex].areas.indexWhere(
      //           (element) =>
      //               element.name.toLowerCase().trim() ==
      //               fixedPath[4].toLowerCase().trim());

      //       var day = int.tryParse(fixedPath[5].trim().characters.last);

      //       day ??= 0;
      //       try {
      //         Day currentDay =
      //             tempData.places[placeIndex].areas[areaIndex].days.singleWhere(
      //           (element) =>
      //               element.day ==
      //               fixedPath[0].toString().trim() + day.toString(),
      //         );
      //       } catch (e, s) {
      //         Day finalday = Day(
      //             day: fixedPath[0].toString().trim() + day.toString(),
      //             files: []);
      //         tempData.places[placeIndex].areas[areaIndex].days.add(finalday);
      //       }
      //       int dayIndex = tempData.places[placeIndex].areas[areaIndex].days
      //           .indexWhere((element) =>
      //               element.day ==
      //               fixedPath[0].toString().trim() + day.toString());

      //       if (element.path.contains(".MP4") &&
      //           !element.path.contains("-small")) {
      //         File file = File(element.path);

      //         FileThumb temp = FileThumb(
      //           file: file,
      //         );
      //         await temp.checkCreateThumbnail();
      //         tempData.places[placeIndex].areas[areaIndex].days[dayIndex].files
      //             .add(temp);
      //         //int(temp.filename);
      //       }

      //       // if (!tempData.places.contains(element)) {
      //       //   if (state != null) tempData.states.add(state);
      //       // }

      //     }
      //     //print(fixedPath[2].substring());
      //   });

      //   ref.read(folderStructureProvider.state).state = tempData;

      //   tempData.states.sort(((a, b) => a.compareTo(b)));

      //   if (tempData.states.isNotEmpty) {
      //     ref.read(stateProvider.state).state = tempData.states[0];
      //   }

      //   for (int i = 0; i < tempData.places.length; i++) {
      //     for (int j = 0; j < tempData.places[i].areas.length; j++) {
      //       for (int u = 0; u < tempData.places[i].areas[j].days.length; u++) {
      //         tempData.fileLength +=
      //             tempData.places[i].areas[j].days[u].files.length;
      //         await tempData.places[i].areas[j].days[u].seprateFiles();
      //       }
      //     }
      //   }

      //   Navigator.pop(context);
      // }
    }
  }
}



  // formatBytes(bytes, {int decimals = 2}) {
  //   if (bytes == 0) return '0 Bytes';
  //   const k = 1024;
  //   var dm = decimals < 0 ? 0 : decimals;
  //   const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  //   var i = (math.log(bytes) / math.log(k)).floor();
  //   return ((bytes) / math.pow(k, i)).toStringAsFixed(dm).toString() +
  //       ' ' +
  //       sizes[i];
  // }

  // uploadToServer(FolderStructure data, BuildContext context,
  //     {bool md5 = false}) async {
  //   var fileCount = 0, jsonSize = 0, fileSize = 0;
  //   if (data.places.isNotEmpty) {
  //     StreamController<int> controller = StreamController<int>();
  //     final progressProvider = StreamProvider<int>((ref) {
  //       return controller.stream;
  //     });
  //     controller.add(0);
  //     showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         //barrierColor: Colors.black,
  //         builder: (_) {
  //           return Consumer(builder: (context, ref, c) {
  //             final stream = ref.watch(progressProvider);
  //             return stream.when(
  //                 data: (dat) => Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         const CircularProgressIndicator(),
  //                         const SizedBox(
  //                           height: 20,
  //                         ),
  //                         Text("Processing $dat / ${data.fileLength} files")
  //                       ],
  //                     ),
  //                 error: (e, s) => Center(
  //                       child: Text(e.toString()),
  //                     ),
  //                 loading: () => Container());
  //           });
  //         });
  //     await Future.forEach<Place>(data.places, (place) async {
  //       await Future.forEach<Area>(place.areas, (area) async {
  //         await Future.forEach<Day>(area.days, (days) async {
  //           if (area.name == 'lahan') {
  //             // print(days.files.length.toString() +
  //             //     ' ' +
  //             //     days.left.length.toString() +
  //             //     ' ' +
  //             //     days.right.length.toString());
  //           }
  //           await Future.forEach<FileThumb>(days.files, (file) async {
  //             // print(file.file.path);

  //             if (md5) {
  //               try {
  //                 String md5Hash = '';
  //                 var p = await Process.run(
  //                     // "cmd /c wmic logicaldisk get name", [],
  //                     // "cmd /c ",
  //                     "powershell /c certutil -hashfile '${file.file.path}' md5",
  //                     // 'powershell /c get-filehash -Algorithm MD5 "${currentFile.file.path}"',
  //                     [],
  //                     runInShell: true);
  //                 if (p.exitCode == 0) {
  //                   if (p.outLines.isNotEmpty)
  //                     md5Hash = p.outLines.elementAt(1);
  //                   var response = await http.put(
  //                       Uri.parse(
  //                           'http://localhost:6000/api/file/${file.file.path}'),
  //                       body: jsonEncode({
  //                         "info": {"md5": md5Hash}
  //                       }),
  //                       headers: {"Content-Type": "application/json"});
  //                   if (response.statusCode == 200) {
  //                     if (md5Hash != '') {
  //                       String newpath = file.file.path.replaceAll(
  //                           file.filename.toString(), "$md5Hash.MP4");
  //                       file.file.renameSync(newpath);
  //                     }
  //                     print(md5Hash);
  //                     // print(response.body);
  //                   } else {
  //                     print(response.statusCode);
  //                   }
  //                 } else {
  //                   print(p.errText);
  //                 }
  //               } catch (e, s) {
  //                 print(e);
  //               }
  //             } else {
  //               File processedJson = File(file.file.path.replaceAll(
  //                   file.filename!,
  //                   file.filename!.replaceAll('.MP4', '_processed.json')));
  //               try {
  //                 int size = await file.file.length();
  //                 fileSize += size;

  //                 bool hasProcessed = false;

  //                 try {
  //                   jsonSize += await processedJson.length();
  //                   hasProcessed = true;
  //                 } catch (e, s) {
  //                   hasProcessed = false;
  //                 }
  //                 Media media = Media.file(file.file, parse: true);
  //                 DateTime modifiedDate = await file.file.lastModified();
  //                 Duration duration = Duration(
  //                     milliseconds:
  //                         int.parse(media.metas["duration"].toString()).abs());

  //                 if (duration.inSeconds < 5) return;

  //                 DateTime startTimeDate = modifiedDate.subtract(duration);
  //                 //2012-02-27 13:27:00

  //                 //print(startTimeDate.toString());
  //                 DateTime startTime = DateTime.parse(
  //                     '${startTimeDate.toString().split(' ').first} 00:00:00.00z');

  //                 bool isLeft = false;
  //                 if (file.file.path.toLowerCase().contains("\\l") ||
  //                     file.file.path.toLowerCase().contains("\\left")) {
  //                   isLeft = true;
  //                 } else if (file.file.path.toLowerCase().contains("\\r") ||
  //                     file.file.path.toLowerCase().contains("\\right")) {
  //                   isLeft = false;
  //                 }
  //                 List<List<double>> coordinates = [];
  //                 if (hasProcessed) {
  //                   try {
  //                     var dat = await processedJson.readAsString();
  //                     List<LocationsData> LocData = [];
  //                     LocData = locationsFromMap(dat);
  //                     int separator = LocData.length ~/ 50;
  //                     for (int i = 0; i < 50; i++) {
  //                       if (i == 0) {
  //                         coordinates.add([LocData[i].lng, LocData[i].lat]);
  //                       } else if (i + separator < LocData.length - separator) {
  //                         coordinates.add([
  //                           LocData[i + separator].lng,
  //                           LocData[i + separator].lat
  //                         ]);
  //                       }
  //                     }
  //                   } catch (e, s) {
  //                     print('$e $s');
  //                   }
  //                 } else {
  //                   coordinates = [
  //                     [87.2788776, 26.46682595],
  //                     [87.278, 26.466],
  //                   ];
  //                 }

  //                 videoFile.VideoFile newFile = videoFile.VideoFile(
  //                     path: file.file.path,
  //                     useable: true,
  //                     info: videoFile.Info(
  //                         rider: place.rider,
  //                         md5: '',
  //                         filename: file.filename!,
  //                         size: size,
  //                         startTime: startTime,
  //                         endTime: startTime.add(duration),
  //                         duration: startTime.add(duration),
  //                         modifiedDate: modifiedDate,
  //                         isLeft: isLeft,
  //                         hasProcessed: hasProcessed),
  //                     area: videoFile.Area(
  //                       city: place.name,
  //                       area: area.name,
  //                       state: place.state,
  //                     ),
  //                     location: videoFile.Location(coordinates: coordinates),
  //                     enabled: true);

  //                 try {
  //                   var response = await http.post(
  //                       Uri.parse('http://localhost:3000/api/file'),
  //                       body: jsonEncode(newFile.toMap()),
  //                       headers: {"Content-Type": "application/json"});
  //                   if (response.statusCode == 201) {
  //                   } else {
  //                     print(response.statusCode.toString() +
  //                         ' ' +
  //                         response.body.toString());
  //                   }
  //                 } catch (e, s) {
  //                   print(e);
  //                 }
  //               } catch (e, s) {
  //                 print('$e $s');
  //               }
  //             }
  //             fileCount++;
  //             //print(fileCount);
  //             controller.add(fileCount);
  //           });
  //         });
  //       });
  //     });

  //     print(fileCount.toString() +
  //         ' Total Size: ' +
  //         formatBytes(fileSize) +
  //         ' Json Size: ' +
  //         formatBytes(jsonSize));
  //     Navigator.pop(context);
  //   }
  // }

