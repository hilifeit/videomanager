import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';
import 'package:videomanager/screens/viewscreen/models/services/searchService.dart';

final checkBoxCountryStateProvider = StateProvider<bool>((ref) {
  return false;
});
final checkBoxStateStateProvider = StateProvider<bool>((ref) {
  return false;
});

class Filter extends StatelessWidget {
  Filter({Key? key, required this.mapController}) : super(key: key);
  final searchChangeNotifierProvider =
      ChangeNotifierProvider<SearchService>((ref) {
    return SearchService();
  });
  final MapController mapController;
  FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
        debugShowCheckedModeBanner: false,
        home: fluent.ScaffoldPage(
          padding: EdgeInsets.zero,
          content: Container(
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 29.w, top: 15.h, right: 21.33.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Filter',
                          style: kTextStyleIbmSemiBold.copyWith(
                              color: primaryColor)),
                      SizedBox(
                        height: 26.h,
                      ),
                      Consumer(builder: (context, ref, c) {
                        final searchService =
                            ref.watch(searchChangeNotifierProvider);

                        return SearchField<Result>(
                            focusNode: focus,
                            // hasOverlay: false,
                            onSubmit: (result) async {
                              await searchService.search(result);
                              FocusScope.of(context).unfocus();
                              FocusScope.of(context).requestFocus(focus);
                            },
                            onSuggestionTap: (item) {
                              mapController.center = LatLng(
                                  item.item!.startCoordinate.lat,
                                  item.item!.startCoordinate.lng);
                            },
                            suggestions: searchService.results
                                .map((e) => SearchFieldListItem<Result>(
                                    e.filename,
                                    item: e,
                                    child: Text(e.filename)))
                                .toList());

                        // fluent.SizedBox(
                        //   child: fluent.AutoSuggestBox(
                        //     showCursor: true,
                        //     onChanged: (value, reason) async {
                        //       await searchService.search(value);
                        //     },
                        //     onSelected: (value) {
                        //       print(value);
                        //     },
                        //     foregroundDecoration: fluent.BoxDecoration(
                        //         border: Border.all(color: Colors.transparent),
                        //         borderRadius:
                        //             fluent.BorderRadius.circular(4.r)),
                        //     placeholder: "Search",
                        //     // decoration: fluent.BoxDecoration(
                        //     //   borderRadius: BorderRadius.circular(4),
                        //     // ),

                        //     leadingIcon: fluent.Padding(
                        //       padding: EdgeInsets.all(15.r),
                        //       child: Icon(
                        //         Videomanager.search,
                        //         size: 18.r,
                        //       ),
                        //     ),
                        //     placeholderStyle: kTextStyleInterMedium,
                        //     style: kTextStyleInterMedium,
                        //     items: searchService.results
                        //         .map((e) => e.filename)
                        //         .toList(),
                        //   ),
                        // );
                      }),
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
                              });
                        }),
                        title: Text(
                          'State',
                          style:
                              kTextStyleInterMedium.copyWith(fontSize: 16.sp),
                        ),
                        children: [
                          ListTile(
                            horizontalTitleGap: 0.r,
                            // contentPadding: EdgeInsets.only(left: 0),
                            leading: Consumer(builder: (context, ref, c) {
                              final checked = ref
                                  .watch(checkBoxStateStateProvider.state)
                                  .state;
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
                                          .read(
                                              checkBoxStateStateProvider.state)
                                          .state = value!;
                                    }),
                              );
                            }),
                            title: Text(
                              'State 1',
                              style: kTextStyleInterMedium.copyWith(
                                  fontSize: 16.sp),
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
          ),
        ));
  }
}
