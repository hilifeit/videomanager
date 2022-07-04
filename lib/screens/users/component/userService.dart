import 'package:videomanager/screens/others/apiHelper.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/model/addnewusermodel.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

final userChangeProvider = ChangeNotifierProvider<UserService>((ref) {
  return UserService._();
});

const String userStorageKey = "users";

class UserService extends ChangeNotifier {
//   load() async {
//  loggedInUser.value! = UserModel.fromJson(json.decode(str));

  UserService._() {
    load();
    fetchAll();
  }

  late final selectedUser = Property<UserModel?>(null, notifyListeners);

  late final loggedInUser = Property<UserModelMini?>(null, notifyListeners);

  late final errorMessage = Property<String>("", notifyListeners);
  final String userEndPoint = 'user';
  final List<UserModelMini> _users = [];
  set users(List<UserModelMini> user) {
    _users.clear();
    _users.addAll(user.toList());
  }

  List<UserModelMini> get users => _users;

//   }
  load() async {
    final userJson = storage.read(userStorageKey);
    if (userJson != null) {
      loggedInUser.value = UserModelMini.fromJson(userJson);
    }
  }

  store() async {
    await storage.write(userStorageKey, loggedInUser.value!.toJson());
    // print(loggedInUser.value!.mobile);
  }

  // Future<UserModel>
  fetchOne(String id) async {
    try {
      var response = await tunnelRequest(
          () => client.get(Uri.parse("${baseURL}user/$id"), headers: {
                "Content-Type": "application/json",
                "x-access-token": loggedInUser.value!.accessToken!
              }));
      if (response.statusCode == 200) {
        selectedUser.value = userModelFromJson(response.body);
        notifyListeners();
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw "$e";
    }
  }

  fetchAll() async {
    // try {

    var response = await tunnelRequest(
        () => client.get(Uri.parse("$baseURL$userEndPoint"), headers: {
              "Content-Type": "application/json",
              "x-access-token": loggedInUser.value!.accessToken!
            }));

    if (response.statusCode == 200) {
      var temp = userModelMiniListFromJson(response.body);
      users = temp;
      notifyListeners();
    } else if (response.statusCode == 403) {
      throw 'token expired';
    } else {
      var error = jsonDecode(response.body);
      // print(error);
      users = [];
      errorMessage.value = error['message'];
      notifyListeners();

      // throw errorMessage;
    }
  }
  // catch (e) {
  //   errorMessage = e.toString();
  //   notifyListeners();
  //   throw e.toString();
  // }
// }

  // selectUser(UserModel? user) {
  //   selectedUser.value = user;
  //   notifyListeners();
  // }

  List<UserModelMini> getByRoles(Roles role) {
    List<UserModelMini> roleUsers = [];

    for (var element in _users) {
      if (element.role == role.index) roleUsers.add(element);
    }
    return roleUsers;
  }

  Future<bool> login(
      {required String username,
      required String password,
      required bool remember}) async {
    try {
      var response = await client.post(Uri.parse("${baseURL}auth/login"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        var temp = userModelMiniFromJson(response.body);
        if (temp.role == Roles.user.index) {
          throw "Normal Users cannot login in Video Manager";
        }
        loggedInUser.value = temp;
        if (remember) {
          await store();
        }

        notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);
        print(error);
        throw error['message'];
      }
    } catch (e, s) {
      throw "$e $s";
    }
  }

  Future<bool> getToken() async {
    try {
      var response = await client.post(
        Uri.parse("${baseURL}auth/token"),
        headers: {
          "Content-Type": "application/json",
          "x-refresh-token": loggedInUser.value!.refreshToken!
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        // if (!json["accessToken"]) {
        //   throw "";
        // }

        loggedInUser.value!.accessToken = json["accessToken"];
        if (storage.read(userStorageKey) != null) {
          store();
        }

        notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);

        return false;
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<bool> delete({required String id}) async {
    try {
      var response = await tunnelRequest(() => client.delete(
            Uri.parse("$baseURL$userEndPoint/$id"),
            headers: {
              "Content-Type": "application/json",
              "x-access-token": loggedInUser.value!.accessToken!
            },
          ));

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
      var response = await client.post(Uri.parse("$baseURL$userEndPoint"),
          headers: {
            "Content-Type": "application/json",
            "x-access-token": loggedInUser.value!.accessToken!
          },
          body: jsonEncode({
            "username": addUser.username,
            "password": addUser.password,
            "mobile": addUser.mobile,
            "name": addUser.name,
            "role": addUser.role,
            "email": addUser.email,
            "superVisor": addUser.superVisor.id
          }));
      if (response.statusCode == 201) {
        // var temp = userModelListFromJson(response.body);
        // users = temp;
        // store();
        notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);
        throw error['message'];
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<bool> edit(
      {required Map<String, dynamic> map, required String id}) async {
    try {
      var response = await tunnelRequest(
          () => client.put(Uri.parse("$baseURL$userEndPoint/$id"),
              headers: {
                "Content-Type": "application/json",
                "x-access-token": loggedInUser.value!.accessToken!
              },
              body: jsonEncode(map)));
      if (response.statusCode == 200) {
        // var temp = userModelListFromJson(response.body);
        // users = temp;
        // store();
        notifyListeners();

        return true;
      } else {
        var error = jsonDecode(response.body);

        throw error['message'];
      }
    } catch (e) {
      throw "$e";
    }
  }
}
