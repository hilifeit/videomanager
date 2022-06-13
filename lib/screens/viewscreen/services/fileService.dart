import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

final fileDetailMiniServiceProvider =
    ChangeNotifierProvider<FileService>((ref) {
  return FileService();
});

class FileService extends ChangeNotifier {
  FileService() {
    fetch();
  }
  List<FileDetailMini> files = [];
  fetch() async {
    try {
      var response = await client.get(Uri.parse("${baseURL}file"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        files = fileDetailMiniFromJson(response.body).toList();
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e, s) {
      throw "$e";
    }
  }
}
