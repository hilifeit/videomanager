import 'package:intl/intl.dart';
import 'package:videomanager/screens/components/custominfo.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';
import 'package:videomanager/screens/users/component/buttonwithloading.dart';
import 'package:videomanager/screens/users/component/dataTable.dart';
import 'package:videomanager/screens/users/component/edituserform.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/component/userstats.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
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
        floatingActionButton: !ResponsiveLayout.isDesktop
            ? FloatingActionButton(
                heroTag: 'mobileApp',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const UserFormMobile();
                  }));
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Videomanager.add_user_svgrepo_com_1,
                  color: whiteColor,
                ),
              )
            : null,
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
                          left: ResponsiveLayout.isDesktop ? 36.sw() : 0.sw(),
                          top: ResponsiveLayout.isDesktop ? 37.sh() : 0.sh(),
                          right: ResponsiveLayout.isDesktop ? 36.sw() : 0.sw(),
                        ),
                        child: Column(
                          children: [
                            if (ResponsiveLayout.isDesktop) ...[
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
                            ],
                            Expanded(
                              child: Consumer(builder: (context, ref, c) {
                                final userService =
                                    ref.watch(userChangeProvider);
                                final users = userService.users;
                                if (ResponsiveLayout.isDesktop) {
                                  return CustomDataTable(
                                    empty: users == null
                                        ? CustomShowMessage.nointernet()
                                        : CustomShowMessage.nodata(),
                                    source: UserModelSource(
                                        context: context, users: users),
                                    column: data,
                                  );
                                }
                                return UserListMobile(users: users);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (ResponsiveLayout.isDesktop)
                      Expanded(
                        child: UserStats(),
                      )
                  ],
                )),
            if (ResponsiveLayout.isDesktop)
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

class UserFormMobile extends StatelessWidget {
  const UserFormMobile({Key? key, this.edit = false}) : super(key: key);
  final bool edit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: edit ? EditUser() : AddUser()));
  }
}

class UserListMobile extends ConsumerWidget {
  const UserListMobile({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<UserModelMini> users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        await ref.read(userChangeProvider).fetchAll();
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
                onTap: () async {
                  await ref.read(userChangeProvider).fetchOne(users[index].id);
                  Future.delayed(const Duration(milliseconds: 10), () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const UserFormMobile(
                        edit: true,
                      );
                    }));
                  });
                },
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withAlpha(180),
                  child: Icon(
                    getIconFromRole(users[index].role),
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  users[index].name,
                  style: kTextStyleIbmMedium.copyWith(
                      fontSize: 16.ssp(),
                      color: Theme.of(context).primaryColor),
                ),
                subtitle: users[index].superVisor != null
                    ? Text(
                        users[index].superVisor!.name,
                        style: kTextStyleIbmMedium.copyWith(fontSize: 16.ssp()),
                      )
                    : null,
                trailing: Text(
                  DateFormat("yyyy-MM-dd").format(users[index].createdAt),
                  style: kTextStyleIbmMedium.copyWith(
                    fontSize: 16.ssp(),
                  ),
                )
                // IconButton(
                //   icon: const Icon(Icons.more_vert),
                //   onPressed: () {},
                // ),
                );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.sh(),
            );
          },
          itemCount: users.length),
    );
  }

  IconData getIconFromRole(int role) {
    if (role == Roles.user.index) return Icons.person;
    if (role == Roles.manager.index) return Icons.manage_accounts;
    return Icons.admin_panel_settings_outlined;
  }
}
