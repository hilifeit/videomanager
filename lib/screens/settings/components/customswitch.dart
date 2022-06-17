import 'package:videomanager/screens/others/exporter.dart';

class CustomSwitch extends ConsumerStatefulWidget {
  const CustomSwitch({
    required this.value,
    required this.onChanged,
    required this.space,
    required this.text,
    Key? key,
  }) : super(key: key);

  final bool value;
  final Function(bool val) onChanged;
  final double space;
  final String text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends ConsumerState<CustomSwitch> {
  bool value = true;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.text,
          style: kTextStyleInterRegular.copyWith(
              color: Colors.black, fontSize: 16.ssp()),
        ),
        Spacer(),
        // SizedBox(
        //   width: widget.space,
        // ),
        Padding(
          padding: EdgeInsets.only(right: 7.sw()),
          child: Switch(
              // activeColor: Theme.of(context).primaryColor,
              value: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
                widget.onChanged(val);
              }),
        ),
      ],
    );
  }
}
