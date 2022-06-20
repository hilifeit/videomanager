import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';

final searchChangeNotifierProvider =
    ChangeNotifierProvider<SearchService>((ref) {
  return SearchService();
});

class SearchService extends ChangeNotifier {
  List<Result> results = [];

  search(String query) async {
    try {
      var response = await client.get(
          Uri.parse("${baseURL}file/search?q=$query"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        SearchItem temp = searchItemFromJson(response.body);
        results = temp.results.toList();
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw "$e";
    }
  }

  add(result) {
    results.add(result);
    // notifyListeners();
  }
}
