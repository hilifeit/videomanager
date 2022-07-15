import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteroverlay.dart';

final filterItemProvider = StateProvider<FilterItemWidgetItem?>((ref) {
  return null;
});

class FilterIconButton extends ConsumerWidget {
  FilterIconButton({Key? key}) : super(key: key);

  final FocusNode foucusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterSelect = ref.watch(filterItemProvider.state).state;
    return InkWell(
      onTap: () {
        if (CustomOverlayEntry().isMenuOpen) {
          CustomOverlayEntry().closeFilter();
        } else {
          CustomOverlayEntry().showFilter(context);
        }
      },
      child: Row(
        children: [
          if (filterSelect != null)
            Padding(
              padding: EdgeInsets.only(right: 5.sw()),
              child: Container(
                  padding: EdgeInsets.all(
                    7.sw(),
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: FilterItemWidget(item: filterSelect)),
            ),
          Container(
            padding: EdgeInsets.all(10.sr()),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4.sr())),
            child:
                Icon(Videomanager.filter, color: Colors.white, size: 18.ssp()),
          ),
        ],
      ),
    );
  }
}
