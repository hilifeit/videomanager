import 'package:videomanager/screens/components/custominfo.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';
import 'package:videomanager/screens/users/component/buttonwithloading.dart';
import 'package:videomanager/screens/users/component/dataTable.dart';
import 'package:videomanager/screens/users/component/edituserform.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/component/userstats.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/viewscreen/components/customSearch.dart';

final editUserProvider = StateProvider<bool>((ref) {
  return false;
});
List<DataColumn> data = [
  DataColumn(
      label: Text(
    "User",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "Email",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "JOINING DATE",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "ROLE",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "ACTION",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
];

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

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
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 36.sw(),
                          top: 37.sh(),
                          right: 36.sw(),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Users',
                                  style: kTextStyleIbmSemiBold.copyWith(
                                    fontSize: 20.ssp(),
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 16.sw(),
                                ),
                                ButtonWithLoading(),
                                SizedBox(
                                  width: 16.sw(),
                                ),
                                SizedBox(
                                  width: 300.sw(),
                                  child: const CustomSearch(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18.sh(),
                            ),
                            Expanded(
                              child: Consumer(builder: (context, ref, c) {
                                final userService =
                                    ref.watch(userChangeProvider);
                                final users = userService.users;
                                return CustomDataTable(
                                  empty: users == null
                                      ? CustomShowMessage.nointernet()
                                      : CustomShowMessage.nodata(),
                                  source: UserModelSource(
                                      context: context, users: users),
                                  column: data,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: UserStats(),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Consumer(builder: (context, ref, c) {
                  final edit = ref.watch(editUserProvider.state).state;
                  return edit ? EditUser() : AddUser();
                }))
          ],
        ));
  }
}
