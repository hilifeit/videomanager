import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/Bug/component/imagePicker.dart';
import 'package:videomanager/screens/Bug/component/wrapProblems.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';

class Bug extends StatelessWidget {
  Bug({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> problems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 80.sw(), top: 9.sh(), right: 40.w),
          height: 42.sh(),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sr()),
                topRight: Radius.circular(8.sr())),
          ),
          child: Row(
            children: [
              Text(
                'Bug Report',
                style: kTextStyleIbmRegular.copyWith(
                  fontSize: 16.ssp(),
                  color: Colors.white,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What Happened?',
                  style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 82.h,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        hintText:
                            'Explain what happened and what should we do to reproduce the problem',
                        hintStyle:
                            kTextStyleIbmRegular.copyWith(fontSize: 16.ssp()),
                        labelStyle: kTextStyleIbmRegularBlack.copyWith(
                            fontSize: 16.ssp())),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'What is the problem related to?',
                  style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MultiSelectWidget(
                  problems: const ["UI", "TEST", "SCREENSHOT"],
                  // onChanged: (p0) {
                  //   print(p0);
                  //   problems.clear();
                  //   problems.addAll(p0);
                  // },
                  onChanged: (val) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please choose atleast one problem';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Attach Image',
                  style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
                ),
                SizedBox(
                  height: 20.sh(),
                ),
                ImagePicker(
                  onChanged: (val) {},
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return 'Please choose atleast one problem';
                    // }
                    // return null;
                  },
                ),
                SizedBox(
                  height: 20.sh(),
                ),
                OutlinedElevatedButtonCombo(
                  outlinedButtonText: 'Cancel',
                  elevatedButtonText: 'Send',
                  center: true,
                  onPressedOutlined: () {},
                  onPressedElevated: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.reset();
                      snack.info('Processing data');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
