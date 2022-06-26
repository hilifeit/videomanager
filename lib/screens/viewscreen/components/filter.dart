import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/components/searchModule.dart';
import 'package:videomanager/screens/viewscreen/services/filterService.dart';

class Filter extends StatelessWidget {
  const Filter({Key? key, required this.mapController}) : super(key: key);

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 29.sw(), top: 15.sh(), right: 21.33.sw()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filter',
                  style: kTextStyleIbmSemiBold.copyWith(color: primaryColor)),
              SizedBox(
                height: 26.sh(),
              ),
              SearchBox(
                mapController: mapController,
              ),
              SizedBox(
                height: 29.sh(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) {
              return ExpansionTile(

                  // tilePadding: EdgeInsets.only(left: 0,right: 10),
                  childrenPadding: EdgeInsets.only(left: 57.sw()),
                  leading: Consumer(builder: (context, ref, c) {
                    final checked = ref.watch(filterServiceProvider);
                    return Checkbox(
                        // visualDensity: VisualDensity.adaptivePlatformDensity,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        side: const BorderSide(
                          width: 1,
                          color: secondaryColorText,
                        ),
                        activeColor: primaryColor,
                        value: checked.onlyNotUsable,
                        onChanged: (value) {
                          checked.toggleUsable(value!);
                          ref.read(selectedFileProvider.state).state = null;
                        });
                  }),
                  title: Text(
                    'Only Damaged',
                    style: kTextStyleInterMedium.copyWith(fontSize: 16.ssp()),
                  ),
                  children: const [
                    // ListTile(
                    //   horizontalTitleGap: 0.r,
                    //   // contentPadding: EdgeInsets.only(left: 0),
                    //   leading: Consumer(builder: (context, ref, c) {
                    //     final checked =
                    //         ref.watch(checkBoxStateStateProvider.state).state;
                    //     return SizedBox(
                    //       width: 15,
                    //       height: 15,
                    //       child: Checkbox(
                    //           materialTapTargetSize:
                    //               MaterialTapTargetSize.padded,
                    //           side: const BorderSide(
                    //             width: 1,
                    //             color: secondaryColorText,
                    //           ),
                    //           activeColor: primaryColor,
                    //           value: checked,
                    //           onChanged: (value) {
                    //             ref
                    //                 .read(checkBoxStateStateProvider.state)
                    //                 .state = value!;
                    //           }),
                    //     );
                    //   }),
                    //   title: Text(
                    //     'State 1',
                    //     style: kTextStyleInterMedium.copyWith(fontSize: 16.ssp()),
                    //   ),
                    // ),
                  ]);
            },
            separatorBuilder: (_, index) {
              return const Divider(
                height: 1,
                thickness: 0.5,
              );
            },
            itemCount: 1,
          ),
        ),
      ],
    );
  }
}
