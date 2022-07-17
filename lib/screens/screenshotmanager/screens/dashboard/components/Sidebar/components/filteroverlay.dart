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
