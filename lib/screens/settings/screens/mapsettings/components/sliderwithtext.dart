import 'package:videomanager/screens/others/exporter.dart';

class CustomSlider extends ConsumerWidget {
  CustomSlider(
      {Key? key,
      required this.text,
      required this.min,
      required this.max,
      required this.value,
      required this.onChanged})
      : super(key: key);
  final String text;
  final double min;
  final double max;
  final double value;
  final sliderState = StateProvider<double>((ref) {
    return 0;
  });
  final Function(double val) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueState = ref.watch(sliderState.state).state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
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
                  min.toInt().toString(),
                  style: kTextStyleIbmRegular.copyWith(
                      fontSize: 14.ssp(), color: Colors.black),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 7.sh(),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 8.sr()),
                        thumbColor: const Color(0xff9FC6DD)),
                    child: Slider(
                      min: min,
                      max: max,
                      activeColor: Theme.of(context).primaryColor,
                      thumbColor: const Color(0xff9FC6DD),
                      inactiveColor: lightWhite,
                      value: valueState,
                      onChanged: (val) {
                        // widget.onChanged(val);
                        ref.read(sliderState.state).state = val;
                        onChanged(val);
                      },
                    ),
                  ),
                ),
                Text(
                  max.toInt().toString(),
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
