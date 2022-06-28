import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/addnewusermodel.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
// import 'package:videomanager/screens/users/component/userService.dart';

// class AddNewUser {
//   AddNewUser(
//       {this.userName = '',
//       this.role = 0,
//       this.name = '',
//       this.email = '',
//       this.password = '',
//       this.mobile = 0,
//       this.id = ''});
//   String userName;
//   int role;
//   String name;
//   String email;
//   String password;
//   int mobile;
//   String id;
// }

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class AddUser extends ConsumerWidget {
  AddUser({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];
  bool edit = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userService = ref.watch(userChangeProvider);
    final selectedUser = ref.watch(userChangeProvider).selectedUser;
    final thisUser = ref.watch(userChangeProvider).user;
    AddNewUser addNewUser = AddNewUser();
    if (selectedUser != null) {
      edit = true;
      addNewUser
        ..userName = selectedUser.username
        ..email = selectedUser.email
        ..mobile = selectedUser.mobile
        ..name = selectedUser.name
        ..role = selectedUser.role
        ..id = selectedUser.id
        ..superVisor = thisUser.id;
    } else {
      edit = false;
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
                  edit ? 'Edit User' : 'Add User',
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
                        // SizedBox(
                        //   width: 88.sw(),
                        //   height: 80.sh(),
                        //   child: Stack(
                        //     children: [
                        //       CircleAvatar(
                        //         backgroundColor: Colors.teal,
                        //         radius: 40.sr(),
                        //       ),
                        //       Positioned(
                        //         bottom: 0,
                        //         right: 0,
                        //         child: CircleAvatar(
                        //           backgroundColor: Colors.white,
                        //           radius: 14.sr(),
                        //           child: CircleAvatar(
                        //             radius: 13.sr(),
                        //             backgroundColor:
                        //                 Theme.of(context).primaryColor,
                        //             child: Icon(
                        //               Videomanager.edit_1,
                        //               color: Colors.white,
                        //               size: 11.04.ssp(),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 35.sh(),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 35.sh(),
                        ),
                        InputTextField(
                          value: edit ? addNewUser.userName : '',
                          title: 'Username',
                          isVisible: true,
                          fillColor: Colors.white,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(), color: Colors.black),
                          validator: (val) => validateUserName(val!),
                          onChanged: (val) {
                            // addUser!.username = val;
                            addNewUser.userName = val;
                            print(addNewUser.userName);
                          },
                        ),
                        SizedBox(
                          height: 14.sh(),
                        ),
                        Text('User Role', style: kTextStyleIbmSemiBold),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        if (edit == true && thisUser.id == selectedUser!.id)
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
                        if (edit == true &&
                            thisUser.role < 2 &&
                            thisUser.id != selectedUser!.id)
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
                        if (!edit && thisUser.role == 1)
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
                              child: const Text('User'),
                            ),
                          ),
                        if (edit)
                          if (thisUser.role >= 2 &&
                              thisUser.id != selectedUser!.id)
                            CustomMenuDropDown(
                                value: menus[edit ? addNewUser.role : 0],
                                onChanged: (val) {
                                  addNewUser.role = int.parse(val.value);
                                },
                                values: menus,
                                helperText: ''),
                        if (!edit)
                          if (thisUser.role >= 2)
                            CustomMenuDropDown(
                                value: menus[edit ? addNewUser.role : 0],
                                onChanged: (val) {
                                  addNewUser.role = int.parse(val.value);
                                },
                                values: menus,
                                helperText: ''),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        InputTextField(
                          value: edit ? addNewUser.name : '',
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
                          value: edit ? addNewUser.email : '',
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
                        if (!edit)
                          InputTextField(
                            title: 'Password',
                            isVisible: true,
                            fillColor: Colors.white,
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp(), color: Colors.black),
                            // validator: (val) => validateRegisterPassword(val!),
                            onChanged: (val) {
                              addNewUser.password = val;
                            },
                          ),
                        SizedBox(height: 14.sh()),
                        InputTextField(
                          value: edit ? addNewUser.mobile.toString() : '',
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
                              elevatedButtonText: edit ? 'Edit' : 'Add',
                              onPressedOutlined: () {
                                if (edit) {
                                  ref.read(userChangeProvider).selectUser(null);
                                }
                              },
                              onPressedElevated: () async {
                                addNewUser.superVisor = thisUser.id;
                                print(addNewUser.superVisor);
                                if (formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                            textSecond: edit
                                                ? 'save the following changes?'
                                                : 'add the following user?',
                                            elevatedButtonText: 'Yes',
                                            onPressedElevated: () async {
                                              if (edit) {
                                                var addNewUserToJson =
                                                    addNewUser.toJson();
                                                var selectedUserToJson =
                                                    selectedUser!.toJson();
                                                Map<String, dynamic> test = {};

                                                for (var element
                                                    in addNewUserToJson
                                                        .entries) {
                                                  if (selectedUserToJson[
                                                          element.key] !=
                                                      element.value) {
                                                    if (element.key !=
                                                        "password") {
                                                      test.addAll({
                                                        element.key:
                                                            element.value
                                                      });
                                                    }
                                                  }
                                                }

                                                if (test.isEmpty) {
                                                  snack.info('No change');
                                                } else {
                                                  try {
                                                    var user = ref.read(
                                                        userChangeProvider);

                                                    await user.edit(
                                                        map: test,
                                                        id: addNewUser.id);

                                                    formKey.currentState!
                                                        .reset();
                                                    ref
                                                        .read(
                                                            userChangeProvider)
                                                        .selectUser(null);
                                                    ref
                                                        .read(
                                                            userChangeProvider)
                                                        .fetchAll();
                                                    snack.success(
                                                        "User Edited Sucessfully");
                                                  } catch (e) {
                                                    snack.error(e);
                                                  }
                                                }
                                              } else {
                                                try {
                                                  var user = ref
                                                      .read(userChangeProvider);
                                                  await user.add(
                                                      addUser: addNewUser);
                                                  snack.success(
                                                      "User Added Sucessfully");
                                                  formKey.currentState!.reset();
                                                  ref
                                                      .read(userChangeProvider)
                                                      .fetchAll();
                                                } catch (e) {
                                                  snack.error(e);
                                                }
                                              }
                                            });
                                      });
                                }
                              },
                            )

                            // OutlineAndElevatedButton(
                            //   textSecond: 'add this user?',
                            //   edit: edit,
                            //   onReset: () {},
                            //   center: true,
                            //   text: edit ? 'Edit' : 'Add',
                            //   onApply: () {
                            //     if (formKey.currentState!.validate()) return true;
                            //     return false;
                            //   },
                            //   onSucess: () async {
                            //     if (edit) {
                            //       var addNewUserToJson = addNewUser.toJson();
                            //       var selectedUserToJson = selectedUser!.toJson();
                            //       Map<String, dynamic> test = {};

                            //       for (var element in addNewUserToJson.entries) {
                            //         if (selectedUserToJson[element.key] !=
                            //             element.value) {
                            //           if (element.key != "password") {
                            //             test.addAll(
                            //                 {element.key: element.value});
                            //           }
                            //         }
                            //       }

                            //       if (test.isEmpty) {
                            //         snack.info('No change');
                            //       } else {
                            //         try {
                            //           var user = ref.read(userChangeProvider);

                            //           await user.edit(
                            //               map: test, id: addNewUser.id);

                            //           formKey.currentState!.reset();
                            //           ref
                            //               .read(userChangeProvider)
                            //               .selectUser(null);
                            //           ref.read(userChangeProvider).fetchAll();
                            //           snack.success("User Edited Sucessfully");
                            //         } catch (e) {
                            //           snack.error(e);
                            //         }
                            //       }
                            //     } else {
                            //       try {
                            //         var user = ref.read(userChangeProvider);
                            //         await user.add(addUser: addNewUser);
                            //         snack.success("User Added Sucessfully");
                            //         formKey.currentState!.reset();
                            //         ref.read(userChangeProvider).fetchAll();
                            //       } catch (e) {
                            //         snack.error(e);
                            //       }
                            //     }
                            //   },
                            // ),
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
