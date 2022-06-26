import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';
import 'package:videomanager/screens/users/model/addnewusermodel.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
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
    fetchAll();
  }
  late UserModel user;
  UserModel? selectedUser;

  UserModel? get userTemp => user;

  String errorMessage = '';

  List<UserModel>? users = [];
  List<UserModel>? get allUsers => users;
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

  Future<UserModel> fetchOne(String id) async {
    try {
      var response = await client.get(Uri.parse("${baseURL}api/user/$id"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        UserModel temp = userModelFromJson(response.body);
        return temp;
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw "$e";
    }
  }

  fetchAll() async {
    try {
      var response = await client.get(Uri.parse("${baseURL}user"), headers: {
        "Content-Type": "application/json",
        "x-access-token": user.accessToken
      });
      if (response.statusCode == 200) {
        var temp = userModelListFromJson(response.body);
        users = temp;
        notifyListeners();
      } else {
        var error = jsonDecode(response.body);
        // print(error);
        users = null;
        errorMessage = error['message'];
        notifyListeners();
        throw errorMessage;
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      throw errorMessage;
    }
  }

  selectUser(UserModel? user) {
    selectedUser = user;
    notifyListeners();
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
        if (temp.role == Roles.user.index) {
          throw "Normal Users cannot login in Video Manager";
        }
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

  Future<bool> delete({required String id}) async {
    try {
      var response = await client.delete(
        Uri.parse("${baseURL}user/$id"),
        headers: {"Content-Type": "application/json"},
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

  Future<bool> add({required AddNewUser addUser}) async {
    try {
      var response = await client.post(Uri.parse("${baseURL}user"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": addUser.userName,
            "password": addUser.password,
            "mobile": addUser.mobile,
            "name": addUser.name,
            "role": addUser.role,
            "email": addUser.email
          }));
      if (response.statusCode == 201) {
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

  Future<bool> edit(
      {required Map<String, dynamic> map, required String id}) async {
    try {
      var response = await client.put(Uri.parse("${baseURL}user/$id"),
          headers: {"Content-Type": "application/json"}, body: jsonEncode(map));
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
}
