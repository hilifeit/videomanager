import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';
import 'package:videomanager/screens/users/component/userTable.dart';
import 'package:videomanager/screens/users/component/userstats.dart';

class Users extends StatelessWidget {
  Users({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String value = 'User';
  final List values = ['User', 'Manager', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(flex: 2, child: UserTable()),
                  Expanded(
                    child: UserStats(),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: AddUser(formKey: formKey, value: value, values: values))
        ],
      ),
    );
  }
}
