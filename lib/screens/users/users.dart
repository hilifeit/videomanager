import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';
import 'package:videomanager/screens/users/component/buttonwithloading.dart';
import 'package:videomanager/screens/users/component/userTable.dart';
import 'package:videomanager/screens/users/component/userstats.dart';
import 'package:videomanager/screens/viewscreen/components/searchModule.dart';

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
                                  child: SearchBox(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18.sh(),
                            ),
                            Expanded(child: UserTable()),
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
                  return AddUser();
                }))
          ],
        ));
  }
}
