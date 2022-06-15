import 'package:videomanager/screens/others/exporter.dart';

class MapsSettings extends ConsumerWidget {
  const MapsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h,left: 81.w),
            child: Text('Map Settings',style: kTextStyleInterSemiBold.copyWith(fontSize: 21.sp,color: primaryColor),),
          ),
          Padding(padding: EdgeInsets.only(top: 43.h,bottom: 73.w),
          child: Column(),)
        ],
      ),
    );
  }
}