import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/models/searchItem.dart';
import 'package:videomanager/screens/viewscreen/services/searchService.dart';

class SearchBox extends ConsumerWidget {
  SearchBox({Key? key, this.mapController}) : super(key: key);
  final FocusNode focus = FocusNode();
  final MapController? mapController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchService = ref.watch(searchChangeNotifierProvider);

    return SearchField<Result>(
        suggestionState: Suggestion.expand,
        focusNode: focus,
        itemHeight: 80.h,
        // hasOverlay: false,
        onSubmit: (result) async {
          await searchService.search(result);
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
          // ignore: use_build_context_synchronously
          FocusScope.of(context).requestFocus(focus);
        },
        onSuggestionTap: (item) {
          if (mapController != null) {
            mapController!.center = LatLng(
                item.item!.startCoordinate.lat, item.item!.startCoordinate.lng);
          }
        },
        suggestions: searchService.results
            .map((e) => SearchFieldListItem<Result>(
                  e.filename,
                  item: e,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    subtitle: Text(
                      '${e.area.area}, ${e.area.city}',
                      style: kTextStyleIbmRegularBlack,
                    ),
                    contentPadding: EdgeInsets.only(
                        right: 10.w, bottom: 0, left: 0, top: 0),
                    leading: Icon(
                      Videomanager.video_file,
                      color: primaryColor,
                      size: 22.r,
                    ),
                    title: Text(
                      e.filename,
                      style:
                          kTextStyleIbmRegularBlack.copyWith(fontSize: 16.sp),
                    ),
                    trailing: Text(
                      'State ${e.area.state}',
                      style: kTextStyleIbmRegularBlack,
                    ),
                  ),
                ))
            .toList());
  }
}



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