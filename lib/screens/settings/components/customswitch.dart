import 'package:videomanager/screens/others/exporter.dart';
import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
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

  late final valueProvider = StateProvider<bool>((ref) {
    return value;
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: kTextStyleInterRegular.copyWith(
              color: Colors.black, fontSize: 16.ssp()),
        ),
        const Spacer(),
        // SizedBox(
        //   width: widget.space,
        // ),
        Consumer(builder: (context, ref, c) {
          final selectedValue = ref.watch(valueProvider.state).state;
          return Padding(
            padding: EdgeInsets.only(right: 7.sw()),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor.withAlpha(64),
                  thumbColor: Theme.of(context).primaryColor,
                  value: selectedValue,
                  onChanged: (val) {
                    ref.read(valueProvider.state).state = selectedValue;
                    onChanged(val);
                  }),
            ),
          );
        }),
      ],
    );
  }
}
