import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';

class Users extends StatelessWidget {
  Users({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String value = 'test1';
  final List values = ['test1', 'test2', 'test3', 'test4', 'test5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Placeholder()),
          SingleChildScrollView(
            child: SizedBox(
                width: 619.sw(),
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 59.sw(), top: 45.sh(), right: 59.sw()),
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
                                  title: 'User',
                                  isVisible: true,
                                  fillColor: Colors.white,
                                  style: kTextStyleIbmSemiBold.copyWith(
                                      fontSize: 16.ssp(), color: Colors.black),
                                  validator: (val) => validateUserName(val!),
                                  onChanged: (val) {},
                                ),
                                SizedBox(
                                  height: 14.sh(),
                                ),
                                Text('User Role', style: kTextStyleIbmSemiBold),
                                SizedBox(
                                  height: 6.sh(),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: secondaryColor,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(5.sr()),
                                      color: Colors.white),
                                  child: DropdownButton<String>(
                                      selectedItemBuilder: (context) {
                                        return [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value,
                                              style: kTextStyleInterRegular
                                                  .copyWith(fontSize: 18.ssp()),
                                            ),
                                          )
                                        ];
                                      },
                                      isExpanded: true,
                                      underline: Container(),
                                      value: value,
                                      icon: Expanded(
                                        child: Icon(
                                          Videomanager.down,
                                          size: 8.5.sr(),
                                          color: Colors.black,
                                        ),
                                      ),
                                      items: values
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        // setState(() {
                                        //   value = val;
                                        // });
                                      }),
                                ),
                                SizedBox(height: 14.sh()),
                                InputTextField(
                                  title: 'Email',
                                  isVisible: true,
                                  fillColor: Colors.white,
                                  style: kTextStyleIbmSemiBold.copyWith(
                                      fontSize: 16.ssp(), color: Colors.black),
                                  validator: (val) => validateEmail(val!),
                                  onChanged: (val) {},
                                ),
                                SizedBox(height: 14.sh()),
                                InputTextField(
                                  title: 'Password',
                                  isVisible: true,
                                  fillColor: Colors.white,
                                  style: kTextStyleIbmSemiBold.copyWith(
                                      fontSize: 16.ssp(), color: Colors.black),
                                  validator: (val) => validatePassword(val!),
                                  onChanged: (val) {},
                                ),
                                SizedBox(height: 14.sh()),
                                InputTextField(
                                  title: 'Mobile Number',
                                  isVisible: true,
                                  fillColor: Colors.white,
                                  style: kTextStyleIbmSemiBold.copyWith(
                                      fontSize: 16.ssp(), color: Colors.black),
                                  validator: (val) => validatePhone(val!),
                                  onChanged: (val) {},
                                ),
                                SizedBox(
                                  height: 60.sh(),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: OutlineAndElevatedButton(
                                      center: true,
                                      text: 'Add',
                                      onApply: () {}),
                                ),
                                SizedBox(height: 20.sh()),
                              ],
                            )),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
