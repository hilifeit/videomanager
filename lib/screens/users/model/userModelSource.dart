import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/users/users.dart';

final editManagerSelectProvider = StateProvider<bool>((ref) {
  return false;
});

enum Roles { user, manager, superAdmin }

String getRole(int value) {
  var role = Roles.values.elementAt(value);
  return role.name.replaceFirst(
      role.name.characters.first, role.name.characters.first.toUpperCase());
}

class UserModelSource extends DataTableSource {
  UserModelSource(
      {required this.context,
      required this.users,
      this.color = dangerSecondary,
      this.status = 'Pending'});

  final BuildContext context;
  final List<UserModelMini> users;

  Color color;
  String status;
  @override
  DataRow? getRow(int index) {
    if (index >= users.length) {
      return null;
    }

    final user = users[index];

    return DataRow2.byIndex(index: index, cells: [
      DataCell(SizedBox(
        height: 41.sh(),
        child: TableUserCard(user: user),
      )),
      DataCell(Text(
        user.id,
        style: kTextStyleTableSubtitle,
      )),
      DataCell(Text(
        DateFormat('yyyy-MM-dd').format(user.createdAt),
        style: kTextStyleTableSubtitle,
      )),
      DataCell(Text(getRole(user.role))),
      DataCell(
        Consumer(builder: (context, ref, c) {
          final thisUser = ref.watch(userChangeProvider).user;
          return (thisUser.role > user.role || thisUser.id == user.id)
              ? PopupMenuButton(
                  offset: const Offset(0, 0),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                          onTap: () async {
                            await ref
                                .read(userChangeProvider)
                                .fetchOne(user.id);
                            ref.read(editUserProvider.state).state = true;
                            final selectedUser =
                                ref.watch(userChangeProvider).selectedUser;
                            if (selectedUser!.role == 0) {
                              ref.read(editManagerSelectProvider.state).state =
                                  true;
                            } else if (selectedUser.role == 1) {
                              ref.read(editManagerSelectProvider.state).state =
                                  false;
                            }
                          },
                          child: CustomPopUpMenuItemChild(
                            icon: Videomanager.edit,
                            text: 'Edit',
                          )),
                      if (thisUser.id != user.id)
                        PopupMenuItem(
                            onTap: () {
                              // ref.read(userChangeProvider).selectUser(user);
                            },
                            child: CustomPopUpMenuItemChild(
                              icon: Videomanager.lock,
                              text: 'Reset Password',
                            )),
                      if (thisUser.id != user.id)
                        PopupMenuItem(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 1),
                                  () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        textSecond: 'delete this user?',
                                        elevatedButtonText: "Yes",
                                        onPressedElevated: () async {
                                          try {
                                            await ref
                                                .read(userChangeProvider)
                                                .delete(id: user.id);

                                            ref
                                                .read(userChangeProvider)
                                                .fetchAll();
                                            snack.success(
                                                'User Deleted Sucessfully');
                                          } catch (e) {
                                            snack.error(e);
                                          }
                                        },
                                      );
                                    });
                              });

                              //ref.read(userChangeProvider).delete(id: user.id);
                            },
                            child: CustomPopUpMenuItemChild(
                              icon: Videomanager.delete,
                              text: 'Delete',
                            )),
                    ];
                  },
                  child: const Icon(Icons.more_vert))
              : const Text("No Permission");
        }),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class CustomPopUpMenuItemChild extends StatelessWidget {
  CustomPopUpMenuItemChild({
    Key? key,
    this.width,
    required this.icon,
    required this.text,
  }) : super(key: key);
  double? width;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.sh(),
      width: width ?? 180.sw(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 17.6.sr(),
          ),
          SizedBox(
            width: 21.3.sw(),
          ),
          Text(
            text,
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 16.ssp(),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.color,
    required this.status,
  }) : super(key: key);

  final Color color;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.sw(),
      height: 22.sh(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sr()),
        color: color,
      ),
      child: Center(
        child: Text(
          status,
          style:
              kTextStyleIbmMedium.copyWith(fontSize: 13.ssp(), color: danger),
        ),
      ),
    );
  }
}

class TableUserCard extends StatelessWidget {
  const TableUserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModelMini user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: kTextStyleTableName,
        ),
        if (user.role != 2)
          Text(
            user.superVisor!.name,
            style: kTextStyleTableSubtitle,
          ),
      ],
    );
  }
}
