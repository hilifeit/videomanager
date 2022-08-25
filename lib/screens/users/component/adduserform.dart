import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/addnewusermodel.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class AddUser extends ConsumerWidget {
  AddUser({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];
  bool edit = false;

  final managerSelectProvider = StateProvider<bool>((ref) {
    return true;
  });
  final userProvider = StateProvider<AddNewUser>((ref) {
    // var managerList = ref
    //     .read(userChangeProvider)
    //     .getByRoles(Roles.manager)
    //     .map((e) => CustomMenuItem(label: e.name, value: e.id))
    //     .toList();
    return AddNewUser(superVisor: SuperVisor());
  });
  CustomMenuItem? editMenuSuperVisor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userChangeProvider);
    final allManagers = userService.getByRoles(Roles.manager);
    final managerMenu = allManagers
        .map((e) => CustomMenuItem(label: e.name, value: e.id))
        .toList();
    // final selectedUser = ref.watch(userChangeProvider).selectedUser.value;
    final thisUser = ref.watch(userChangeProvider).loggedInUser.value;
    var selectManager = ref.watch(managerSelectProvider.state).state;
    final addNewUser = ref.watch(userProvider.state).state;
    if (managerMenu.isNotEmpty) {
      addNewUser.superVisor.id = managerMenu.first.value;
    }
    // if (selectedUser != null) {
    //   edit = true;
    //   addNewUser
    //     ..username = selectedUser.username
    //     ..email = selectedUser.email
    //     ..mobile = selectedUser.mobile
    //     ..name = selectedUser.name
    //     ..role = selectedUser.role
    //     ..superVisor.id = selectedUser.superVisor!.id
    //     ..id = selectedUser.id;
    // } else {
    //   edit = false;
    // }
    final double padding = !ResponsiveLayout.isMobile ? 59.sw() : 20.sw();
    return Container(
      height: double.infinity,
      color: Theme.of(context).primaryColor.withOpacity(0.15),
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding:
                EdgeInsets.only(left: padding, top: 45.sh(), right: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add User',
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
                            // addUser!.username= val;
                            addNewUser.username = val;
                          },
                        ),
                        SizedBox(
                          height: 14.sh(),
                        ),
                        Text('User Role',
                            style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 16.ssp(),
                            )),
                        SizedBox(
                          height: 6.sh(),
                        ),

                        if (!edit && thisUser!.role == 1)
                          SinglERoleText(
                              style: kTextStyleIbmSemiBold.copyWith(
                                  fontSize: 16.ssp(), color: Colors.black),
                              text: 'User'),
                        // if (edit)
                        //   if (thisUser.role >= 2 &&
                        //       thisUser.id != selectedUser!.id)
                        //     CustomMenuDropDown(
                        //         value: menus[edit ? addNewUser.role : 0],
                        //         onChanged: (val) {
                        //           addNewUser.role = int.parse(val.value);
                        //         },
                        //         values: menus,
                        //         helperText: ''),
                        if (managerMenu.isNotEmpty)
                          if (thisUser!.role >= 2)
                            CustomMenuDropDown(
                                value: menus[addNewUser.role],
                                onChanged: (val) {
                                  addNewUser.role = int.parse(val.value);

                                  if (addNewUser.role == 1) {
                                    ref
                                        .read(managerSelectProvider.state)
                                        .state = false;
                                  } else {
                                    ref
                                        .read(managerSelectProvider.state)
                                        .state = true;
                                  }
                                },
                                values: menus,
                                helperText: ''),
                        if (managerMenu.isEmpty)
                          SinglERoleText(
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp(), color: Colors.black),
                            text: 'Manager',
                          ),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        if (managerMenu.isNotEmpty)
                          if (selectManager && thisUser!.role >= 2) ...[
                            Text('Supervisor',
                                style: kTextStyleIbmSemiBold.copyWith(
                                    fontSize: 16.ssp())),
                            SizedBox(
                              height: 14.sh(),
                            ),
                            CustomMenuDropDown(
                                value: managerMenu.first,
                                onChanged: (val) {
                                  addNewUser.superVisor.id = val.value;
                                },
                                values: managerMenu,
                                helperText: ''),
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
                          validator: (val) => validateName(val!),
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
                        if (!edit)
                          InputTextField(
                            value: addNewUser.password,
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
                          // value: addNewUser.mobile.toString(),
                          isdigits: true,
                          limit: true,
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
                              elevatedButtonText: 'Add',
                              onPressedOutlined: () {},
                              onPressedElevated: () async {
                                if (formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                            textSecond:
                                                'add the following user?',
                                            elevatedButtonText: 'Yes',
                                            onPressedElevated: () async {
                                              {
                                                if (managerMenu.isEmpty) {
                                                  addNewUser.role = 1;
                                                  addNewUser.superVisor.id =
                                                      thisUser!.id;
                                                }
                                                if (!selectManager) {
                                                  addNewUser.superVisor.id =
                                                      thisUser!.id;
                                                }
                                                if (thisUser!.role == 1) {
                                                  addNewUser.superVisor.id =
                                                      thisUser.id;
                                                }
                                                try {
                                                  var user = ref
                                                      .read(userChangeProvider);
                                                  await user.add(
                                                      addUser: addNewUser);
                                                  snack.success(
                                                      "User Added Sucessfully");
                                                  addNewUser
                                                    ..username = ""
                                                    ..email = ""
                                                    ..mobile = 0
                                                    ..name = ""
                                                    ..password = ""
                                                    ..role = 0;
                                                  ref
                                                      .read(
                                                          managerSelectProvider
                                                              .state)
                                                      .state = true;
                                                  formKey.currentState!.reset();

                                                  ref
                                                      .read(userChangeProvider)
                                                      .fetchAll();
                                                } catch (e) {
                                                  snack.error("$e");
                                                }
                                              }
                                            });
                                      });
                                }
                              },
                            )),
                        SizedBox(height: 100.sh()),
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

class SinglERoleText extends StatelessWidget {
  SinglERoleText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.sh(),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4.sr(),
        ),
        border: Border.all(
          color: lightGrey,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13.sw(), bottom: 10.sh(), top: 10.sh()),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: style),
        ),
      ),
    );
  }
}
