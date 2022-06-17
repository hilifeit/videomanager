import 'package:videomanager/screens/others/exporter.dart';

class TextWithDDownButton<T> extends ConsumerStatefulWidget {
  const TextWithDDownButton(
      {Key? key,
      required this.text,
      required this.value,
      required this.onChanged,
      required this.values,
      required this.helperText})
      : super(key: key);
  final String text;
  final T value;
  final Function(dynamic val) onChanged;
  final List<T> values;
  final String helperText;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextWithDDownButtonState();
}

class _TextWithDDownButtonState<T> extends ConsumerState<TextWithDDownButton> {
  late T value;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.sw(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
          ),
          SizedBox(
            width: 106.sw(),
            height: 49.sh(),
            child: Container(
              color: lightWhite.withOpacity(0.22),
              child: DropdownButton<T>(
                  selectedItemBuilder: (context) {
                    return [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sw(), vertical: 12.sh()),
                        child: Text(
                          "$value ${widget.helperText}",
                          style: kTextStyleInterRegular.copyWith(
                              fontSize: 18.ssp()),
                        ),
                      )
                    ];
                  },
                  // isExpanded: true,
                  underline: Container(),
                  value: widget.value,
                  icon: Expanded(
                    child: Icon(
                      Videomanager.down,
                      size: 8.5.sr(),
                      color: Colors.black,
                    ),
                  ),
                  items: widget.values.map<DropdownMenuItem<T>>((value) {
                    return DropdownMenuItem<T>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      value = val as T;
                    });
                    widget.onChanged(val);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
