import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';
// import 'package:videomanager/screens/users/component/userService.dart';

class AddNewUser {
  String? userName = '';
  int? role = 0;
  String? name = '';
  String? email = '';
  String? password = '';
  int? mobile = 0;
}

class AddUser extends ConsumerWidget {
  AddUser({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final ScrollController _scrollController = ScrollController();

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 2),
    CustomMenuItem(label: "Manager", value: 1),
    CustomMenuItem(label: "Admin", value: 0),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userService = ref.watch(userChangeProvider);

    AddNewUser addNewUser = AddNewUser();

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
                  'Add User',
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
                        CustomMenuDropDown(
                            value: menus[0],
                            onChanged: (val) {
                              // addNewUser.role = val.value;
                              print(val.value);
                            },
                            values: menus,
                            helperText: ''),
                        SizedBox(
                          height: 6.sh(),
                        ),
                        InputTextField(
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
                            onReset: () {},
                            center: true,
                            text: 'Add',
                            onApply: () {
                              if (formKey.currentState!.validate()) return true;
                              return false;
                            },
                            onSucess: () {
                              var user = ref.read(userChangeProvider);

                              user.add(addUser: addNewUser);
                              snack.success("User Added Sucessfully");
                              formKey.currentState!.reset();
                              ref.read(userChangeProvider).fetchAll();
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
