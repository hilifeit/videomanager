import 'package:videomanager/screens/others/exporter.dart';

class TextWithDDownButton extends ConsumerStatefulWidget {
  TextWithDDownButton({Key? key, required this.text, required this.value})
      : super(key: key);
  final String text;
  final double value;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextWithDDownButtonState();
}

class _TextWithDDownButtonState extends ConsumerState<TextWithDDownButton> {
  double value = 0;
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
              child: DropdownButton<double>(
                  selectedItemBuilder: (context) {
                    return [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sw(), vertical: 12.sh()),
                        child: Text(
                          "0",
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
                  items: <double>[widget.value, 20]
                      .map<DropdownMenuItem<double>>((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text(value.toInt().toString()),
                    );
                  }).toList(),
                  onChanged: (val) {}),
            ),
          ),
        ],
      ),
    );
  }
}
