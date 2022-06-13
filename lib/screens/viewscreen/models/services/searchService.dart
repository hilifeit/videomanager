import 'package:flutter/cupertino.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';

class SearchService extends ChangeNotifier {
  List<Result> results = [];

  search(String query) async {
    try {
      var response = await client.get(
          Uri.parse(baseURL + "file/search?q=$query"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        SearchItem temp = searchItemFromMap(response.body);
        results = temp.results.toList();
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e, s) {
      throw "$e";
    }
  }
}
