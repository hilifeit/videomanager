import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class Bug extends StatelessWidget {
  const Bug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What Happened?',
            style: kTextStyleIbmSemiBold,
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
                maxLines: 2,
                decoration: InputDecoration(
                    hintText:
                        'Explain what happened and what should we do to reproduce the problem',
                    hintStyle: kTextStyleIbmRegular)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'What is te problem related to?',
            style: kTextStyleIbmSemiBold,
          ),
          SizedBox(
            height: 20.h,
          ),
          Wrap(
            spacing: 20.0.w,
            runSpacing: 20.0.w,
            children: [
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'UI',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'Video',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'Screenshot',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'Hardware',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'UI',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'UI',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'UI',
                    style: kTextStyleIbmRegularBlack,
                  )),
              Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: darkGrey),
                  child: Text(
                    'Screenshot',
                    style: kTextStyleIbmRegularBlack,
                  )),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Attach Image',
            style: kTextStyleIbmSemiBold,
          ),
          SizedBox(
            height: 20.h,
          ),
          Icon(
            Icons.attach_file,
            size: 22.sp,
          )
        ],
      ),
    );
  }
}
