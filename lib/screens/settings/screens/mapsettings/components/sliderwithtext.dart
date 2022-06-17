import 'package:videomanager/screens/others/exporter.dart';

class CustomSlider extends ConsumerStatefulWidget {
  const CustomSlider(
      {Key? key,
      required this.text,
      required this.min,
      required this.max,
      required this.value,
      required this.onChanged,
      this.isDiscrete = false})
      : super(key: key);
  final String text;
  final double min;
  final double max;
  final double value;
  final bool isDiscrete;
  final Function(double val) onChanged;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomSliderState();
}

class _CustomSliderState extends ConsumerState<CustomSlider> {
  double value = 0.0;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
        ),
        SizedBox(
          height: 16.sh(),
          width: 546.63.sw(),
          child: Padding(
            padding: EdgeInsets.only(right: 32.37.sw()),
            child: Row(
              children: [
                Text(
                  widget.min.toInt().toString(),
                  style: kTextStyleIbmRegular.copyWith(
                      fontSize: 14.ssp(), color: Colors.black),
                ),
                SizedBox(width: 10.sw()),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      // overlayShape: SliderComponentShape.noOverlay,
                      valueIndicatorColor:
                          Theme.of(context).primaryColor.withOpacity(0.15),
                      showValueIndicator: widget.isDiscrete
                          ? ShowValueIndicator.onlyForDiscrete
                          : ShowValueIndicator.onlyForContinuous,
                      valueIndicatorTextStyle:
                          kTextStyleIbmRegular.copyWith(color: Colors.black),
                      // valueIndicatorShape: const RoundSliderOverlayShape(),
                      // trackHeight: 7.sh(),
                      // thumbShape:
                      //     RoundSliderThumbShape(enabledThumbRadius: 8.sr()),
                      // thumbColor: const Color(0xff9FC6DD))
                    ),
                    child: Slider(
                      label: value.round().toString(),
                      divisions: widget.isDiscrete
                          ? (widget.max - widget.min).toInt()
                          : null,
                      min: widget.min,
                      max: widget.max,
                      activeColor: Theme.of(context).primaryColor,
                      thumbColor: const Color(0xff9FC6DD),
                      inactiveColor: lightWhite,
                      value: value,
                      onChanged: (val) {
                        // widget.onChanged(val);
                        setState(() {
                          value = val;
                        });
                        widget.onChanged(val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sw(),
                ),
                Text(
                  widget.max.toInt().toString(),
                  style: kTextStyleIbmRegular.copyWith(
                      fontSize: 14.ssp(), color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
