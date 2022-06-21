import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';

final userChangeProvider = ChangeNotifierProvider<UserService>((ref) {
  return UserService();
});

const String userStorageKey = "users";

class UserService extends ChangeNotifier {
//   load() async {
//  user = UserModel.fromJson(json.decode(str));

  UserService() {
    load();
  }
  late UserModel user;

  UserModel? get userTemp => user;
//   }
  load() async {
    final userJson = storage.read(userStorageKey);
    if (userJson != null) {
      user = UserModel.fromJson(userJson);
    }
  }

  store() async {
    await storage.write(userStorageKey, user.toJson());
    // print(user.mobile);
  }

  fetch() async {
    try {
      var response = await client.get(Uri.parse("${baseURL}api/user"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        UserModel temp = userModelFromJson(response.body);
        user = temp;
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<bool> login(
      {required String username, required String password}) async {
    try {
      var response = await client.post(Uri.parse("${baseURL}auth/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        var temp = userModelFromJson(response.body);
        user = temp;
        store();
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
}
