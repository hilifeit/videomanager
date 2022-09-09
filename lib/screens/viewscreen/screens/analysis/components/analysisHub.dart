import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/analysis.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class AnalysisHub extends ConsumerWidget {
  AnalysisHub({Key? key, required this.files}) : super(key: key);
  final List<FileDetailMini> files;
  final currentFileProvider = StateProvider<int>((ref) {
    return 0;
  });
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
          child: Text(index.toString()),
        ),
        ElevatedButton.icon(
            onPressed: () {
              if (index < files.length - 1) {
                ref.read(currentFileProvider.state).state++;
              }
            },
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.verified,
                color: Colors.greenAccent,
              ),
            ),
            label: Text("Match")),
        SizedBox(
          width: 10.sw(),
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.help,
                color: Colors.orangeAccent,
              ),
            ),
            label: Text("Not Sure")),
        SizedBox(
          width: 10.sw(),
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: Padding(
              padding: EdgeInsets.all(8.sr()),
              child: const Icon(
                Icons.dangerous,
                color: Colors.redAccent,
              ),
            ),
            label: Text("No Match"))
      ],
    );
    return PathAnalysis(
      key: Key(index.toString()),
      files: files,
      file: element,
      itemBox: item,
      info: info,
    );
  }
}
