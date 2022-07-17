import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteroverlay.dart';

final filterModuleServiceProvider = ChangeNotifierProvider<FilterService>((ref) {
  return FilterService._();
});

class FilterService extends ChangeNotifier {
  FilterService._();

  List<FilterItemWidgetItem> get items => filterItems;

  List<FilterItemWidgetItem> filterItems = [
    FilterItemWidgetItem(
        icon: Icon(
          Videomanager.pending,
          color: Colors.black,
          size: 14.88.ssp(),
        ),
        text: 'Pending'),
    FilterItemWidgetItem(
        icon: Icon(
          Icons.done,
          color: Colors.black,
          size: 14.88.ssp(),
        ),
        text: 'Complete'),
    FilterItemWidgetItem(
        icon: Icon(
          Videomanager.ongoing,
          color: Colors.black,
          size: 14.88.ssp(),
        ),
        text: 'Ongoing'),
    FilterItemWidgetItem(
      icon: Icon(
        Videomanager.complete,
        color: Colors.black,
        size: 14.88.ssp(),
      ),
      text: 'Approved',
    ),
    FilterItemWidgetItem(
        icon: Padding(
          padding: EdgeInsets.only(left: 2.sw()),
          child: SvgPicture.asset(
            'assets/images/rejected.svg',
            // color: Colors.black,
            width: 12.57.sw(),
            height: 13.62.sh(),
          ),
        ),
        text: 'Rejected'),
    FilterItemWidgetItem(
      icon: Icon(
        Videomanager.refresh,
        color: Colors.black,
        size: 14.88.ssp(),
      ),
      text: 'All',
    ),
  ];
}
