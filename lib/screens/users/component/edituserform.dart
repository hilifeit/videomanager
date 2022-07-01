import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/addnewusermodel.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/users/users.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class EditUser extends ConsumerWidget {
  EditUser({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];

  final edituserProvider = StateProvider<AddNewUser>((ref) {
    return AddNewUser(superVisor: SuperVisor());
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userChangeProvider);
    final allManagers = userService.getByRoles(Roles.manager);
    final managerMenu = allManagers
        .map((e) => CustomMenuItem(label: e.name, value: e.id))
        .toList();
    final selectedUser = ref.watch(userChangeProvider).selectedUser;
    final thisUser = ref.watch(userChangeProvider).user;
    var editSelectManager = ref.watch(editManagerSelectProvider.state).state;
    final addNewUser = ref.watch(edituserProvider.state).state;

    var dd;
    if (selectedUser != null) {
      addNewUser
        ..username = selectedUser.username
        ..email = selectedUser.email
        ..mobile = selectedUser.mobile
        ..name = selectedUser.name
        ..role = selectedUser.role
        ..superVisor.id = selectedUser.superVisor!.id
        ..id = selectedUser.id;

      // dd = managerMenu.firstWhere((element) => element.value == selectedUser.superVisor!.id);
      for (var element in managerMenu) {
        if (element.value == selectedUser.superVisor!.id) {
          dd = managerMenu[managerMenu.indexOf(element)];
          break;
          // index = ;CustomMenuItem(label: element.label, value: element.value);
          // print(dd.label);
        }
      }
    }

    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          child: Padding(
            padding:
                EdgeInsets.only(left: 59.sw(), top: 45.sh(), right: 59.sw()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit User',
                  style: kTextStyleIbmRegular.copyWith(
                      fontSize: 32.ssp(), color: Colors.black),
                ),
                // SizedBox(
                //   height: 39.sh(),
                // ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35.sh(),
                        ),
                        InputTextField(
                          value: addNewUser.username,
                          title: 'username',
                          isVisible: true,
                          fillColor: Colors.white,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(), color: Colors.black),
                          validator: (val) => validateUserName(val!),
                          onChanged: (val) {
                            addNewUser.username = val;
                          },
                        ),
                        SizedBox(
                          height: 14.sh(),
                        ),
                        Text('User Role', style: kTextStyleIbmSemiBold),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        if (thisUser.id == selectedUser!.id)
                          Container(
                            height: 55.sh(),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4.sr(),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 13.sw(), bottom: 10.sh(), top: 10.sh()),
                              child: Text(getRole(selectedUser.role)),
                            ),
                          ),
                        if (thisUser.role < 2 && thisUser.id != selectedUser.id)
                          Container(
                            height: 55.sh(),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4.sr(),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 13.sw(), bottom: 10.sh(), top: 10.sh()),
                              child: Text(getRole(selectedUser.role)),
                            ),
                          ),
                        if (thisUser.role >= 2 && selectedUser.role < 1)
                          CustomMenuDropDown(
                              value: menus[addNewUser.role],
                              onChanged: (val) {
                                addNewUser.role = int.parse(val.value);
                                if (addNewUser.role == 1) {
                                  ref
                                      .read(editManagerSelectProvider.state)
                                      .state = false;
                                } else if (addNewUser.role == 0) {
                                  ref
                                      .read(editManagerSelectProvider.state)
                                      .state = true;
                                }
                              },
                              values: menus,
                              helperText: ''),
                        if (thisUser.role >= 2 && selectedUser.role == 1)
                          CustomMenuDropDown(
                              value: menus[addNewUser.role],
                              onChanged: (val) {
                                addNewUser.role = int.parse(val.value);
                                if (addNewUser.role == 1) {
                                  ref
                                      .read(editManagerSelectProvider.state)
                                      .state = false;
                                } else if (addNewUser.role == 0) {
                                  ref
                                      .read(editManagerSelectProvider.state)
                                      .state = true;
                                }
                              },
                              values: menus,
                              helperText: ''),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        if (editSelectManager &&
                            thisUser.id != selectedUser.id &&
                            selectedUser.role < 1) ...[
                          Text('Supervisor', style: kTextStyleIbmSemiBold),
                          SizedBox(
                            height: 14.sh(),
                          ),
                          if (thisUser.role >= 2)
                            CustomMenuDropDown(
                                value: dd,
                                onChanged: (val) {
                                  addNewUser.superVisor.id = val.value;
                                },
                                values: managerMenu,
                                helperText: '')
                        ],
                        if (editSelectManager &&
                            thisUser.id != selectedUser.id &&
                            selectedUser.role == 1) ...[
                          Text('Supervisor', style: kTextStyleIbmSemiBold),
                          SizedBox(
                            height: 14.sh(),
                          ),
                          if (thisUser.role >= 2)
                            CustomMenuDropDown(
                                value: managerMenu.first,
                                onChanged: (val) {
                                  addNewUser.superVisor.id = val.value;
                                },
                                values: managerMenu,
                                helperText: '')
                        ],
                        SizedBox(
                          height: 6.sh(),
                        ),
                        InputTextField(
                          value: addNewUser.name,
                          title: 'Name',
                          isVisible: true,
                          fillColor: Colors.white,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(), color: Colors.black),
                          validator: (val) => validateLastName(val!),
                          onChanged: (val) {
                            addNewUser.name = val;
                          },
                        ),
                        SizedBox(height: 14.sh()),
                        InputTextField(
                          value: addNewUser.email,
                          title: 'Email',
                          isVisible: true,
                          fillColor: Colors.white,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(), color: Colors.black),
                          validator: (val) => validateEmail(val!),
                          onChanged: (val) {
                            addNewUser.email = val;
                          },
                        ),
                        SizedBox(height: 14.sh()),
                        InputTextField(
                          value: addNewUser.mobile.toString(),
                          isdigits: true,
                          title: 'Mobile Number',
                          isVisible: true,
                          fillColor: Colors.white,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(), color: Colors.black),
                          validator: (val) => validatePhone(val!),
                          onChanged: (val) {
                            addNewUser.mobile = int.parse(val);
                          },
                        ),
                        SizedBox(
                          height: 60.sh(),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: OutlinedElevatedButtonCombo(
                            center: true,
                            spacing: 16.sw(),
                            width: 96.sw(),
                            height: 32.sh(),
                            outlinedButtonText: 'Cancel',
                            elevatedButtonText: 'Edit',
                            onPressedOutlined: () {
                              ref.read(editUserProvider.state).state = false;
                              ref.read(userChangeProvider).selectUser(null);
                            },
                            onPressedElevated: () async {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                          textSecond:
                                              'save the following changes?',
                                          elevatedButtonText: 'Yes',
                                          onPressedElevated: () async {
                                            var addNewUserToJson =
                                                addNewUser.toJson();
                                            var selectedUserToJson =
                                                selectedUser.toJson();
                                            Map<String, dynamic> test = {};

                                            for (var element
                                                in addNewUserToJson.entries) {
                                              if (selectedUserToJson[
                                                      element.key] !=
                                                  element.value) {
                                                if (element.key != "password"
                                                    //     &&
                                                    // element.key !=
                                                    //     "superVisor"
                                                    ) {
                                                  test.addAll({
                                                    element.key: element.value
                                                  });
                                                }
                                              }
                                            }

                                            if (test.isEmpty) {
                                              snack.info('No change');
                                            } else {
                                              try {
                                                var user = ref
                                                    .read(userChangeProvider);

                                                await user.edit(
                                                    map: test,
                                                    id: addNewUser.id);
                                                ref
                                                    .read(
                                                        editUserProvider.state)
                                                    .state = false;

                                                formKey.currentState!.reset();
                                                ref
                                                    .read(userChangeProvider)
                                                    .selectUser(null);
                                                ref
                                                    .read(userChangeProvider)
                                                    .fetchAll();
                                                snack.success(
                                                    "User Edited Sucessfully");
                                              } catch (e) {
                                                snack.error(e);
                                              }
                                            }
                                          });
                                    });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.sh()),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
