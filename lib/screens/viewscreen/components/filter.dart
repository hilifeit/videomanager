import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/others/constant.dart';
import 'package:videomanager/screens/others/widgets.dart';
import 'package:videomanager/screens/viewscreen/components/searchdelegate.dart';
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
                  onTap: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
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
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
            itemBuilder: (_, index) {
              return ExpansionTile(

                  // tilePadding: EdgeInsets.only(left: 0,right: 10),
                  childrenPadding: EdgeInsets.only(left: 57.w),
                  leading: Consumer(builder: (context, ref, c) {
                    final checked =
                        ref.watch(checkBoxStateStateProvider.state).state;
                    return Checkbox(
                        // visualDensity: VisualDensity.adaptivePlatformDensity,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
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
                      horizontalTitleGap: 0.r,
                      // contentPadding: EdgeInsets.only(left: 0),
                      leading: Consumer(builder: (context, ref, c) {
                        final checked =
                            ref.watch(checkBoxStateStateProvider.state).state;
                        return SizedBox(
                          width: 15,
                          height: 15,
                          child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
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
                              }),
                        );
                      }),
                      title: Text(
                        'State 1',
                        style: kTextStyleInterMedium.copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ]);
            },
            separatorBuilder: (_, index) {
              return const Divider(
                height: 1,
                thickness: 0.5,
              );
            },
            itemCount: 3,
          ))
        ],
      ),
    );
  }
}
