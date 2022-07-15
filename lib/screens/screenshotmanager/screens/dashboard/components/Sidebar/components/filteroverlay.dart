import 'package:videomanager/screens/others/exporter.dart';

class FilterItemWidgetItem {
  FilterItemWidgetItem({required this.icon, required this.text});
  final String text;
  final Widget icon;
}

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

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final FilterItemWidgetItem item;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        item.icon,
        SizedBox(
          width: 9.06.sw(),
        ),
        Text(
          item.text,
          style: kTextStyleIbmRegular.copyWith(
              fontSize: 14.ssp(), color: Colors.black),
        ),
      ],
    );
  }
}