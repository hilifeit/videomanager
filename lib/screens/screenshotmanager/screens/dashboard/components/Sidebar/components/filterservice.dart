import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteroverlay.dart';

final filterModuleServiceProvider =
    ChangeNotifierProvider<FilterService>((ref) {
  return FilterService._();
});

class FilterService extends ChangeNotifier {
  FilterService._();
  List<int> _selectedItems = [];
  set selectedItems(List<int> int) {
    _selectedItems.addAll(int.toList());
  }

  List<int> get selectedItems => _selectedItems;

  List<FilterItemWidgetItem> filterItems = [
    FilterItemWidgetItem(
      iconData: Videomanager.pending,
      text: 'Pending',
    ),
    FilterItemWidgetItem(
      iconData: Icons.done,
      text: 'Complete',
    ),
    FilterItemWidgetItem(
      iconData: Videomanager.ongoing,
      text: 'Ongoing',
    ),
    FilterItemWidgetItem(
      iconData: Videomanager.complete,
      text: 'Approved',
    ),
    FilterItemWidgetItem(
      iconData: 'assets/images/rejected.svg',
      text: 'Rejected',
    ),
  ];

  addItems(
    int index,
  ) {
    if (_selectedItems.isEmpty) {
      _selectedItems.add(index);
      filterItems[index].selected = true;
    } else {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
        filterItems[index].selected = false;
      } else {
        _selectedItems.add(index);
        filterItems[index].selected = true;
      }
    }
    
    notifyListeners();
  }

  removeItems(int index) {
    _selectedItems.remove(index);
    filterItems[index].selected = false;
   
    notifyListeners();
  }

  reset() {
    _selectedItems = [];
    for (int i = 0; i < filterItems.length; i++) {
      filterItems[i].selected = false;
      notifyListeners();
    }
  }
}
