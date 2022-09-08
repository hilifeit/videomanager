import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/analysis.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class AnalysisHub extends ConsumerWidget {
  const AnalysisHub({Key? key, required this.files}) : super(key: key);
  final List<FileDetailMini> files;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fileservice = ref.read(fileDetailMiniServiceProvider);
    var element = files[0];
    var item =
        fileservice.getRect(element.boundingBox!, SelectedArea.transformer);
    return PathAnalysis(
      files: files,
      file: files[0],
      itemBox: item,
      manualVerification: false,
    );
  }
}
