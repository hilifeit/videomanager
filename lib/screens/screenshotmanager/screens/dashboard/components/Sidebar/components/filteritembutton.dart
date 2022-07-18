import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filterservice.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';

final filterItemProvider = StateProvider<List<int?>>((ref) {
  return [];
});

class FilterIconButton extends ConsumerWidget {
  FilterIconButton({Key? key}) : super(key: key);

  final FocusNode foucusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterSelect = ref.watch(filterModuleServiceProvider).selectedItems;
    // final filterSelect = filterService.selectedItems;
    return Row(
      children: [
        if (filterSelect.isNotEmpty)
          Text(
            'Filtered By:',
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 13.ssp(),
              color: Colors.black,
            ),
          ),
        SizedBox(
          width: 8.sw(),
        ),
        if (filterSelect.isNotEmpty)
          Wrap(
              spacing: 10.sw(),
              children: List.generate(
                filterSelect.length,
                (index) => SizedBox(
                  width: 65.sw(),
                  height: 27.sh(),
                  child: Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          left: 0,
                          bottom: 0,
                          child: StatusCard(
                              status: filterSelect[index].toString())),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(filterModuleServiceProvider)
                                .removeItems(filterSelect[index]);
                          },
                          child: Icon(
                            Videomanager.close,
                            color: darkGrey,
                            size: 10.sr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        const Spacer(),
        InkWell(
          onTap: () {
            if (CustomOverlayEntry().isMenuOpen) {
              CustomOverlayEntry().closeFilter();
            } else {
              CustomOverlayEntry().showFilter(context);
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.sr()),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4.sr())),
            child:
                Icon(Videomanager.filter, color: Colors.white, size: 18.ssp()),
          ),
        ),
      ],
    );
  }
}
