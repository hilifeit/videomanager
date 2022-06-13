import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/searchModule.dart';

final checkBoxCountryStateProvider = StateProvider<bool>((ref) {
  return false;
});
final checkBoxStateStateProvider = StateProvider<bool>((ref) {
  return false;
});

class Filter extends StatelessWidget {
  Filter({Key? key, required this.mapController}) : super(key: key);

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              SearchBox(
                mapController: mapController,
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
                        side: const BorderSide(
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
                              side: const BorderSide(
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
          ),
        ),
      ],
    );
  }
}
