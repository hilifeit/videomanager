import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
// import 'package:videomanager/screens/users/component/userService.dart';

class AddNewUser {
  AddNewUser(
      {this.userName = '',
      this.role = 0,
      this.name = '',
      this.email = '',
      this.password = '',
      this.mobile = 0,
      this.id = ''});
  String userName;
  int role;
  String name;
  String email;
  String password;
  int mobile;
  String id;
}

class AddUser extends ConsumerWidget {
  AddUser({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final ScrollController _scrollController = ScrollController();

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0),
    CustomMenuItem(label: "Manager", value: 1),
  ];
  bool edit = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userService = ref.watch(userChangeProvider);
    final selectedUser = ref.watch(userChangeProvider).selectedUser;
    final userRole = ref.watch(userChangeProvider).user.role;
    AddNewUser addNewUser = AddNewUser();
    if (selectedUser != null) {
      edit = true;
      addNewUser
        ..userName = selectedUser.username
        ..email = selectedUser.email
        ..mobile = selectedUser.mobile
        ..name = selectedUser.name
        ..role = selectedUser.role
        ..id = selectedUser.id;
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
                SizedBox(
                  height: 39.sh(),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 88.sw(),
                          height: 80.sh(),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                                radius: 40.sr(),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14.sr(),
                                  child: CircleAvatar(
                                    radius: 13.sr(),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Icon(
                                      Videomanager.edit_1,
                                      color: Colors.white,
                                      size: 11.04.ssp(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35.sh(),
                              ),
                            ],
                          ),
                        ),
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
                        if (userRole == 1)
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
                                  left: 13.sw(), bottom: 17.sh(), top: 17.sh()),
                              child: const Text('User'),
                            ),
                          ),
                        if (userRole >= 2)
                          CustomMenuDropDown(
                              value: menus[edit ? addNewUser.role : 0],
                              onChanged: (val) {
                                addNewUser.role = val.value;
                                print(val.value);
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
                          child: OutlineAndElevatedButton(
                            edit: edit,
                            onReset: () {},
                            center: true,
                            text: edit ? 'Edit' : 'Add',
                            onApply: () {
                              if (formKey.currentState!.validate()) return true;
                              return false;
                            },
                            onSucess: () {
                              if (!edit) {
                                try {
                                  var user = ref.read(userChangeProvider);

                                  user.add(addUser: addNewUser);
                                  snack.success("User Added Sucessfully");
                                  formKey.currentState!.reset();
                                  ref.read(userChangeProvider).fetchAll();
                                } catch (e) {
                                  snack.error(e);
                                }
                              } else {
                                try {
                                  var user = ref.read(userChangeProvider);

                                  user.edit(addUser: addNewUser);
                                  snack.success("User Edited Sucessfully");
                                  formKey.currentState!.reset();
                                  ref.read(userChangeProvider).fetchAll();
                                  ref.read(userChangeProvider).selectUser(null);
                                } catch (e) {
                                  snack.error(e);
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 120.sh()),
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
