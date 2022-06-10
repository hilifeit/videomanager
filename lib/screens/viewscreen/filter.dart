import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/components/TextField.dart';
import 'package:videomanager/screens/others/constant.dart';
import 'package:videomanager/screens/others/widgets.dart';
import 'package:videomanager/screens/video/video.dart';
import 'package:videomanager/videomanager_icons.dart';

final checkBoxCountryStateProvider = StateProvider<bool>((ref) {
  return false;
});
final checkBoxStateStateProvider = StateProvider<bool>((ref) {
  return false;
});

class Filter extends StatelessWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 29.w, top: 15.h, right: 21.33.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter',
                    style: kTextStyleIbmSemiBold.copyWith(color: primaryColor)),
                SizedBox(
                  height: 26.h,
                ),
                InputTextField(
                  hintStyle: kTextStyleInterMedium,
                  title: 'Search',
                  isVisible: false,
                  fillColor: secondaryColor,
                  prefixIcon: Icon(Videomanager.search,
                      size: 15.sp, color: Colors.black),
                ),
                SizedBox(
                  height: 29.h,
                ),
                Row(
                  children: [
                    Consumer(builder: (context, ref, c) {
                      final checked =
                          ref.watch(checkBoxCountryStateProvider.state).state;
                      return Checkbox(
                          side: BorderSide(
                            width: 1,
                            color: secondaryColorText,
                          ),
                          activeColor: primaryColor,
                          value: checked,
                          onChanged: (value) {
                            ref.read(checkBoxCountryStateProvider.state).state =
                                value!;
                          });
                    }),
                    Text(
                      'Country',
                      style: kTextStyleInterMedium.copyWith(fontSize: 16.sp),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffd1d1d1),
            height: 0.5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                childrenPadding: EdgeInsets.only(left: 57.w),
                  leading: Consumer(builder: (context, ref, c) {
                    final checked =
                        ref.watch(checkBoxStateStateProvider.state).state;
                    return Checkbox(
                        side: BorderSide(
                          width: 1,
                          color: secondaryColorText,
                        ),
                        activeColor: primaryColor,
                        value: checked,
                        onChanged: (value) {
                          ref.read(checkBoxStateStateProvider.state).state =
                              value!;
                        });
                  }),
                  title: Text(
                    'State',
                    style: kTextStyleInterMedium.copyWith(fontSize: 16.sp),
                  ),
                  children: [
                    ListTile(
                      leading: Consumer(builder: (context, ref, c) {
                            final checked = ref
                                .watch(checkBoxStateStateProvider.state)
                                .state;
                            return Checkbox(
                                side: BorderSide(
                                  width: 1,
                                  color: secondaryColorText,
                                ),
                                activeColor: primaryColor,
                                value: checked,
                                onChanged: (value) {
                                  ref
                                      .read(checkBoxStateStateProvider.state)
                                      .state = value!;
                                });
                          }),
                      title: Text(
                            'State 1',
                            style:
                                kTextStyleInterMedium.copyWith(fontSize: 16.sp),
                          ),
                    ),
                    
                  ]
                  // List.generate(
                  //     10,
                  //     (index) => Text(
                  //           'Item $index',
                  //         )),
                  )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         Consumer(builder: (context, ref, c) {
              //           final checked =
              //               ref.watch(checkBoxStateProvider.state).state;
              //           return
              //           Checkbox(
              //               side: BorderSide(
              //                 width: 1,
              //                 color: secondaryColorText,
              //               ),
              //               activeColor: primaryColor,
              //               value: checked,
              //               onChanged: (value) {
              //                 ref.read(checkBoxStateProvider.state).state =
              //                     value!;
              //               });
              //         }),
              //         Text(
              //           'State',
              //           style: kTextStyleInterMedium.copyWith(fontSize: 16.sp),
              //         ),
              //       ],
              //     ),
              //     Icon(Icons.expand_more,color: Colors.black,),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
