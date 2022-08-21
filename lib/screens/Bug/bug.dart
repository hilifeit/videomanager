import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class Bug extends StatefulWidget {
  Bug({Key? key}) : super(key: key);

  @override
  State<Bug> createState() => _BugState();
}

class _BugState extends State<Bug> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> problems = [
    'UI',
    'Video',
    'Screenshot',
    'Hardware',
    'UI1',
    'Video1',
    'Screenshot1',
    'Hardware1'
  ];
  List<String> selectedProblems = [];

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
                    // validator: ,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:
                          'Explain what happened and what should we do to reproduce the problem',
                      hintStyle:
                          kTextStyleIbmRegular.copyWith(fontSize: 16.ssp()),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'What is te problem related to?',
                  style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Wrap(
                    spacing: 20.0.w,
                    runSpacing: 20.0.w,
                    children: problems
                        .asMap()
                        .entries
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (selectedProblems.contains(e.value)) {
                                setState(() {
                                  selectedProblems.remove(e.value);
                                });
                              } else {
                                setState(() {
                                  selectedProblems.add(e.value);
                                });
                              }

                              // setState(() {
                              //   selectedProblems.add(e.value);
                              // });
                              print(selectedProblems);
                            },
                            child: Container(
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: selectedProblems.contains(e.value)
                                        ? primaryColor
                                        : darkGrey),
                                child: Text(
                                  e.value,
                                  style: selectedProblems.contains(e.value)
                                      ? kTextStyleIbmRegular.copyWith(
                                          fontSize: 16.ssp(),
                                          color: Colors.white)
                                      : kTextStyleIbmRegularBlack.copyWith(
                                          fontSize: 16.ssp()),
                                )),
                          ),
                        )
                        .toList()),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Attach Image',
                  style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Icon(
                  Icons.attach_file,
                  size: 22.sp,
                ),
                OutlinedElevatedButtonCombo(
                  outlinedButtonText: 'Cancel',
                  elevatedButtonText: 'Send',
                  center: true,
                  onPressedOutlined: () {},
                  onPressedElevated: () {},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
