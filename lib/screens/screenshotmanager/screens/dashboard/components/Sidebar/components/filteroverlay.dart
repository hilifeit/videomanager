import 'package:videomanager/screens/others/exporter.dart';

class FilterItemWidgetItem {
  FilterItemWidgetItem(
      {required this.icon, required this.text, this.selected = false});
  final String text;
  final Widget icon;
  bool selected;
}

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final FilterItemWidgetItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.sh(),
      ),
      color: item.selected
          ? Color(0xff40667D).withOpacity(0.5)
          : Colors.transparent,
      child: Row(
        children: [
          item.icon,
          SizedBox(
            width: 9.06.sw(),
          ),
          Text(
            item.text,
            style: kTextStyleIbmRegular.copyWith(
                fontSize: 14.ssp(),
                color: item.selected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
