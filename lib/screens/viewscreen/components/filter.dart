import 'package:map/map.dart';
import 'package:videomanager/screens/components/assignuser/assignmanager.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';
import 'package:videomanager/screens/viewscreen/components/AssignedAreaCard.dart';
import 'package:videomanager/screens/viewscreen/components/customSearch.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/filterService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

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
                  style: kTextStyleIbmSemiBold.copyWith(
                      color: primaryColor, fontSize: 18.ssp())),
              SizedBox(
                height: 26.sh(),
              ),
              const CustomSearch(),
              // SearchBox(
              //   mapController: mapController,
              // ),
              SizedBox(
                height: 29.sh(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ListView(
              // ListView.separated(
              // itemBuilder: (_, index) {
              children: [
                ExpansionTile(
                    initiallyExpanded: true,

                    // tilePadding: EdgeInsets.only(left: 0,right: 10),
                    childrenPadding: EdgeInsets.only(left: 57.sw()),
                    leading: Consumer(builder: (context, ref, c) {
                      final checked = ref.read(filterServiceProvider);
                      final val = ref.watch(filterServiceProvider).state;

                      return Checkbox(

                          // visualDensity: VisualDensity.adaptivePlatformDensity,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: const BorderSide(
                            width: 1,
                            color: secondaryColorText,
                          ),
                          activeColor: primaryColor,
                          value: val,
                          onChanged: (value) {
                            checked.togglestate(value!);
                            ref.read(selectedFileProvider.state).state = null;
                          });
                    }),
                    title: Text(
                      'State',
                      style: kTextStyleInterMedium.copyWith(fontSize: 16.ssp()),
                    ),
                    children: List.generate(7, (index) {
                      return Consumer(builder: (context, ref, c) {
                        final checked = ref.read(filterServiceProvider);
                        return ListTile(
                          onTap: () {
                            var fileService =
                                ref.read(fileDetailMiniServiceProvider);
                            var centerOffseet = fileService
                                .filesInStates[index].boundingBox!.center;
                            SelectedArea.transformer.controller.zoom = 9.3;
                            SelectedArea.transformer.controller.center =
                                LatLng(centerOffseet.dx, centerOffseet.dy);
                          },
                          title: Text(
                            'State ${index + 1}',
                            style: kTextStyleInterMedium.copyWith(
                                fontSize: 16.ssp()),
                          ),
                          leading: Consumer(
                            builder: ((context, ref, child) {
                              final val = ref
                                  .watch(filterServiceProvider)
                                  .statesState[index];
                              return Checkbox(
                                  tristate: false,
                                  // visualDensity: VisualDensity.adaptivePlatformDensity,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  side: const BorderSide(
                                    width: 1,
                                    color: secondaryColorText,
                                  ),
                                  activeColor: primaryColor,
                                  value: val,
                                  onChanged: (value) {
                                    checked.toggleStateSingle(value!, index);
                                    ref.read(selectedFileProvider.state).state =
                                        null;
                                  });
                            }),
                          ),
                        );
                      });
                    })),
                ExpansionTile(

                    // tilePadding: EdgeInsets.only(left: 0,right: 10),
                    childrenPadding: EdgeInsets.only(left: 57.sw()),
                    leading: Consumer(builder: (context, ref, c) {
                      final checked = ref.read(filterServiceProvider);
                      final val =
                          ref.watch(filterServiceProvider).onlyNotUsable;
                      return Checkbox(
                          // visualDensity: VisualDensity.adaptivePlatformDensity,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: const BorderSide(
                            width: 1,
                            color: secondaryColorText,
                          ),
                          activeColor: primaryColor,
                          value: val,
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
                    ]),
                ExpansionTile(

                    // tilePadding: EdgeInsets.only(left: 0,right: 10),
                    childrenPadding: EdgeInsets.only(left: 57.sw()),
                    leading: Consumer(builder: (context, ref, c) {
                      final checked = ref.read(filterServiceProvider);
                      final val = ref.watch(filterServiceProvider).onlyPair;

                      return Checkbox(
                          tristate: true,
                          // visualDensity: VisualDensity.adaptivePlatformDensity,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: const BorderSide(
                            width: 1,
                            color: secondaryColorText,
                          ),
                          activeColor: primaryColor,
                          value: val,
                          onChanged: (value) {
                            checked.togglePair(value);
                            ref.read(selectedFileProvider.state).state = null;
                          });
                    }),
                    title: Text(
                      'Only Pair',
                      style: kTextStyleInterMedium.copyWith(fontSize: 16.ssp()),
                    ),
                    children: const []),
              ]

              // separatorBuilder: (_, index) {
              //   return const Divider(
              //     height: 1,
              //     thickness: 0.5,
              //   );
              // },
              // itemCount: 2,
              ),
        ),
        Divider(),
        Expanded(
          flex: 2,
          child: Consumer(builder: (context, ref, c) {
            final areas = ref.watch(fileDetailMiniServiceProvider).areas;
            final selectedArea =
                ref.watch(selectedAreaServiceProvider).selectedArea.value;
            return ListView.separated(
              itemCount: areas.length,
              itemBuilder: (_, index) {
                return AssignedAreaCard(
                    area: areas[index],
                    selected: selectedArea != null
                        ? selectedArea == areas[index]
                        : false);
              },
              separatorBuilder: (_, index) {
                return SizedBox(
                  height: 8.sh(),
                );
              },
            );
          }),
        )
      ],
    );
  }
}
