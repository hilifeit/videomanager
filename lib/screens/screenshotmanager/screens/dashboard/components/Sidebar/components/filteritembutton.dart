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
    return Row(
      children: [
        Text(
          'Filtered By:',
          style: kTextStyleIbmRegular.copyWith(
            fontSize: 11.ssp(),
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10.sw(),
        ),
        if (filterSelect.isNotEmpty)
          Wrap(
              spacing: 10.sw(),
              children: List.generate(
                filterSelect.length,
                (index) => StatusCard(status: filterSelect[index].toString()),
              )),
        Spacer(),
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
