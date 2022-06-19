import 'package:videomanager/screens/dashboard/dashboard.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';

List<CustomCard> items = [
  CustomCard(
      isvisible: false,
      height: 139.sh(),
      width: 235.sw(),
      number: 15,
      text: 'Video Uploaded',
      color: Color(0xffBADBEF),
      icon: Videomanager.videooutline),
  CustomCard(
      isvisible: false,
      height: 139.sh(),
      width: 235.sw(),
      number: 15,
      text: 'Video Assigned',
      color: Color(0xffBDD0FF),
      icon: Videomanager.add_user_svgrepo_com_1),
  CustomCard(
      isvisible: false,
      height: 139.sh(),
      width: 235.sw(),
      number: 15,
      text: 'Review issued',
      color: Color(0xffC2BDFF),
      icon: Videomanager.refresh),
  CustomCard(
      isvisible: false,
      height: 139.sh(),
      width: 235.sw(),
      number: 15,
      text: 'Review Approved',
      color: Color(0xffFFE1BD),
      icon: Videomanager.check),
];

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
          Expanded(
              child: Column(
            children: [
              Expanded(flex: 2, child: Placeholder()),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 66.sw(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Statistics',
                        style: kTextStyleInterSemiBold.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 21.ssp(),
                        ),
                      ),
                      SizedBox(
                        height: 60.sh(),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(right: 26.sw()),
                          scrollDirection: Axis.horizontal,
                          children: items,
                        ),
                      ),
                      SizedBox(
                        height: 56.sh(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
          AddUser(formKey: formKey, value: value, values: values)
        ],
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  const AddUser({
    Key? key,
    required this.formKey,
    required this.value,
    required this.values,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final String value;
  final List values;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          width: 619.sw(),
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
                            title: 'User',
                            isVisible: true,
                            fillColor: Colors.white,
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp(), color: Colors.black),
                            validator: (val) => validateUserName(val!),
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
                                borderRadius: BorderRadius.circular(5.sr()),
                                color: Colors.white),
                            child: DropdownButton<String>(
                                selectedItemBuilder: (context) {
                                  return values
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value,
                                              style: kTextStyleInterRegular
                                                  .copyWith(fontSize: 18.ssp()),
                                            ),
                                          ))
                                      .toList();
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
                                    .map<DropdownMenuItem<String>>((value) {
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
                          ),
                          SizedBox(height: 14.sh()),
                          InputTextField(
                            title: 'Password',
                            isVisible: true,
                            fillColor: Colors.white,
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp(), color: Colors.black),
                            validator: (val) => validatePassword(val!),
                          ),
                          SizedBox(height: 14.sh()),
                          InputTextField(
                            title: 'Mobile Number',
                            isVisible: true,
                            fillColor: Colors.white,
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp(), color: Colors.black),
                            validator: (val) => validatePhone(val!),
                          ),
                          SizedBox(
                            height: 60.sh(),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: OutlineAndElevatedButton(
                                center: true, text: 'Add', onApply: () {}),
                          ),
                          SizedBox(height: 20.sh()),
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
