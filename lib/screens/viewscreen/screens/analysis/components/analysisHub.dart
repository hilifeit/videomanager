import 'dart:developer';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/analysis.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class AnalysisHub extends ConsumerWidget {
  AnalysisHub({Key? key, required this.files, this.action}) : super(key: key);
  final List<FileDetailMini> files;
  final currentFileProvider = StateProvider<int>((ref) {
    return 0;
  });

  PreviousAction? action, tempAction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fileservice = ref.read(fileDetailMiniServiceProvider);
    var index = ref.watch(currentFileProvider.state).state;
    var element = files[index];
    var item =
        fileservice.getRect(element.boundingBox!, SelectedArea.transformer);

    var info = Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text((index + 1).toString()),
        ),
        ElevatedButton.icon(
            onPressed: () {
              matchPair(context, index: index, ref: ref, cleanPair: true);
            },
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.verified,
                color: Colors.greenAccent,
              ),
            ),
            label: const Text("Match")),
        SizedBox(
          width: 10.sw(),
        ),
        ElevatedButton.icon(
            onPressed: () {
              matchPair(context, index: index, ref: ref);
            },
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.help,
                color: Colors.orangeAccent,
              ),
            ),
            label: const Text("Not Sure")),
        SizedBox(
          width: 10.sw(),
        ),
        ElevatedButton.icon(
            onPressed: () {
              if (index < files.length - 1) {
                if (tempAction != null) {
                  action = tempAction!..match = Matcher.NoMatch;
                }

                ref.read(currentFileProvider.state).state++;
              } else if (index == files.length - 1) {
                endProcess(context);
              }
            },
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.dangerous,
                color: Colors.redAccent,
              ),
            ),
            label: const Text("No Match"))
      ],
    );
    return PathAnalysis(
      key: Key(index.toString()),
      files: files,
      file: element,
      itemBox: item,
      info: info,
      onMatch: (newData) {
        tempAction = PreviousAction(
            file1: newData.file1,
            file2: newData.file2,
            image1: newData.image1,
            image2: newData.image2,
            match: newData.match);
      },
      previousAction: action,
      undo: action == null
          ? null
          : () async {
              if (action!.match != Matcher.NoMatch) {
                try {
                  CustomOverlayEntry().showLoader();
                  var fileService = ref.read(fileDetailMiniServiceProvider);
                  var status = await fileService.pairFiles(
                    id: action!.file1!.id,
                    body: {"cleanPair": "null", "pair": action!.file2!.id},
                  );
                  CustomOverlayEntry().closeLoader();
                  if (status) {
                    action!.file2!.pair = null;
                    action!.file2!.cleanPair = false;
                    files.insert(action!.file2Index!, action!.file2!);
                    action = null;
                    if (index > 0) ref.read(currentFileProvider.state).state--;
                  }
                } catch (e, s) {
                  snack.error(e);
                }
              } else {
                if (index > 0) ref.read(currentFileProvider.state).state--;
              }
            },
    );
  }

  matchPair(BuildContext context,
      {required int index,
      required WidgetRef ref,
      bool cleanPair = false}) async {
    if (tempAction!.file1 != null && tempAction!.file2 != null) {
      // print(data.first.id.toString() + "" + data.last.id.toString());

      var fileService = ref.read(fileDetailMiniServiceProvider);
      try {
        CustomOverlayEntry().showLoader();
        var status = await fileService.pairFiles(
            id: tempAction!.file1!.id,
            body: {"cleanPair": cleanPair, "pair": tempAction!.file2!.id});
        CustomOverlayEntry().closeLoader();
        if (status) {
          tempAction!.file2!.pair = tempAction!.file1!.id;
          tempAction!.file2!.cleanPair = cleanPair;
          tempAction!.file1!.pair = tempAction!.file2!.id;
          tempAction!.file1!.cleanPair = cleanPair;
          var file2index = files.indexOf(tempAction!.file2!);
          files.remove(tempAction!.file2);
          if (index < files.length - 1) {
            action = PreviousAction(
                file1: tempAction!.file1,
                file2: tempAction!.file2,
                image1: tempAction!.image1,
                image2: tempAction!.image2,
                match: cleanPair ? Matcher.Match : Matcher.NotSure,
                file2Index: file2index);

            Future.delayed(const Duration(milliseconds: 20), () {
              ref.read(currentFileProvider.state).state++;
            });
          } else if (index == files.length - 1) {
            Future.delayed(Duration(milliseconds: 10), () {
              endProcess(context);
            });
          }
        }
      } catch (e, s) {
        CustomOverlayEntry().closeLoader();
        print("$e $s");
        snack.error(e);
      }
    }
  }

  endProcess(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pop(context);
    });
  }
}
