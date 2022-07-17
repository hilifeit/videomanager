import 'package:videomanager/screens/others/exporter.dart';

class FilterItemWidgetItem {
  FilterItemWidgetItem(
      {required this.iconData, required this.text, this.selected = false});
  final Object iconData;
  final String text;
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
    Color color = item.selected ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.sh(),
      ),
      color: item.selected
          ? Color(0xff40667D).withOpacity(0.5)
          : Colors.transparent,
      child: Row(
        children: [
          item.iconData is IconData
              ? Icon(
                  item.iconData as IconData,
                  color: color,
                  size: 14.88.ssp(),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 2.sw()),
                  child: SvgPicture.asset(
                    item.iconData.toString(),
                    color: color,
                    width: 12.57.sw(),
                    height: 13.62.sh(),
                  ),
                ),
          SizedBox(
            width: 9.06.sw(),
          ),
          Text(
            item.text,
            style:
                kTextStyleIbmRegular.copyWith(fontSize: 14.ssp(), color: color),
          ),
        ],
      ),
    );
  }
}
