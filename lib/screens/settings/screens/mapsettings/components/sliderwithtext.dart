import 'package:videomanager/screens/others/exporter.dart';

class CustomSliderComponentShape extends SliderComponentShape {
  CustomSliderComponentShape({required this.currentValue});
  final double currentValue;
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return const Size(10, 10);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    Paint paint = Paint()..color = const Color(0xff9FC6DD);
    // drawText(context.canvas,
    //     text: currentValue.toInt().toString(), position: center);
    Path path = Path();

    path.addRRect(RRect.fromRectXY(
        Rect.fromCenter(center: center, width: 40.sw(), height: 25.sh()),
        4.sr(),
        4.sr()));
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12.ssp()),
        text: currentValue.toInt().toString());
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();

    // path.addRect(Rect.fromCenter(center: center, width: 40, height: 25));
    context.canvas.drawPath(path, paint);
    tp.paint(context.canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }
}

class CustomSliderComponentShapeRoundHollow extends SliderComponentShape {
  CustomSliderComponentShapeRoundHollow({required this.currentValue});
  final double currentValue;
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return const Size(10, 10);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    Paint paint = Paint()..color = Colors.white;
    Paint paintInside = Paint()..color = primaryColor;
    // drawText(context.canvas,
    //     text: currentValue.toInt().toString(), position: center);
    Path path = Path();

    // path.addRRect(

    path.addOval(Rect.fromCircle(center: center, radius: 7.sr()));
    //   RRect.fromRectXY(
    //     Rect.fromCenter(center: center, width: 20.sw(), height: 20.sh()),
    //     10.sr(),
    //     10.sr()));

    // TextSpan span = TextSpan(
    //     style: TextStyle(color: Colors.black, fontSize: 12.ssp()),
    //     text: currentValue.toInt().toString());
    // TextPainter tp = TextPainter(
    //     text: span,
    //     textAlign: TextAlign.center,
    //     textDirection: TextDirection.ltr);
    // tp.layout();

    // // path.addRect(Rect.fromCenter(center: center, width: 40, height: 25));
    context.canvas.drawPath(path, paint);
    context.canvas.drawCircle(center, 5.sr(), paintInside);
    // tp.paint(context.canvas,
    //     Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }
}

class CustomSliderRectThumb extends StatelessWidget {
  CustomSliderRectThumb(
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

  late final valueProvider = StateProvider<double>((ref) {
    return value;
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
        ),
        // Consumer(
        //   builder: (context, ref, c) {
        //     final currentValue = ref.watch(valueProvider.state).state;
        //     return Text(" (${currentValue.toInt().toString()})");
        //   },
        // ),
        const Spacer(),
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
                SizedBox(width: 10.sw()),
                Expanded(
                  child: Consumer(builder: (context, ref, c) {
                    final currentValue = ref.watch(valueProvider.state).state;
                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          // overlayShape: SliderComponentShape.noOverlay,
                          // valueIndicatorColor:
                          //     Theme.of(context).primaryColor.withOpacity(0.5),
                          // showValueIndicator: isDiscrete
                          //     ? ShowValueIndicator.onlyForDiscrete
                          //     : ShowValueIndicator.onlyForContinuous,
                          // valueIndicatorTextStyle: kTextStyleIbmRegular
                          //     .copyWith(color: Colors.black),
                          thumbShape: CustomSliderComponentShape(
                              currentValue: currentValue)),
                      child: Slider(
                        label: currentValue.round().toString(),
                        divisions: isDiscrete ? (max - min).toInt() : null,
                        min: min,
                        max: max,
                        activeColor: Theme.of(context).primaryColor,
                        thumbColor: const Color(0xff9FC6DD),
                        inactiveColor: lightGrey,
                        value: currentValue,
                        onChanged: (val) {
                          ref.read(valueProvider.state).state = val;
                          // widget.onChanged(val);

                          onChanged(val);
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(
                  width: 10.sw(),
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width - 2.sw();
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderHollowThumb extends StatelessWidget {
  CustomSliderHollowThumb(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.isDiscrete = false})
      : super(key: key);

  final double value;
  final bool isDiscrete;
  final Function(double val) onChanged;

  late final valueProvider = StateProvider<double>((ref) {
    return value;
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 6.sh(),
          width: 100.sw(),
          child: Expanded(
            child: Consumer(builder: (context, ref, c) {
              final currentValue = ref.watch(valueProvider.state).state;
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 3.sh(),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackShape: CustomTrackShape(),

                    // overlayShape: SliderComponentShape.noOverlay,
                    // valueIndicatorColor:
                    //     Theme.of(context).primaryColor.withOpacity(0.5),
                    // showValueIndicator: isDiscrete
                    //     ? ShowValueIndicator.onlyForDiscrete
                    //     : ShowValueIndicator.onlyForContinuous,
                    // valueIndicatorTextStyle: kTextStyleIbmRegular
                    //     .copyWith(color: Colors.black),
                    thumbShape: CustomSliderComponentShapeRoundHollow(
                        currentValue: currentValue)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Slider(
                    label: currentValue.round().toString(),
                    activeColor: Colors.white,
                    thumbColor: const Color(0xff9FC6DD),
                    inactiveColor: Theme.of(context).primaryColor,
                    value: currentValue,
                    onChanged: (val) {
                      ref.read(valueProvider.state).state = val;
                      // widget.onChanged(val);

                      onChanged(val);
                    },
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}



// class CustomSlider extends ConsumerStatefulWidget {
//   const CustomSlider(
//       {Key? key,
//       required this.text,
//       required this.min,
//       required this.max,
//       required this.value,
//       required this.onChanged,
//       this.isDiscrete = false})
//       : super(key: key);
//   final String text;
//   final double min;
//   final double max;
//   final double value;
//   final bool isDiscrete;
//   final Function(double val) onChanged;

  
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CustomSliderState();
// }

// class _CustomSliderState extends ConsumerState<CustomSlider> {
//   double value = 0.0;
//   @override
//   void initState() {
//     super.initState();
//     value = widget.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           widget.text,
//           style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
//         ),
//         SizedBox(
//           height: 16.sh(),
//           width: 546.63.sw(),
//           child: Padding(
//             padding: EdgeInsets.only(right: 32.37.sw()),
//             child: Row(
//               children: [
//                 Text(
//                   widget.min.toInt().toString(),
//                   style: kTextStyleIbmRegular.copyWith(
//                       fontSize: 14.ssp(), color: Colors.black),
//                 ),
//                 SizedBox(width: 10.sw()),
//                 Expanded(
//                   child: SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       // overlayShape: SliderComponentShape.noOverlay,
//                       valueIndicatorColor:
//                           Theme.of(context).primaryColor.withOpacity(0.5),
//                       showValueIndicator: widget.isDiscrete
//                           ? ShowValueIndicator.onlyForDiscrete
//                           : ShowValueIndicator.onlyForContinuous,
//                       valueIndicatorTextStyle:
//                           kTextStyleIbmRegular.copyWith(color: Colors.black),
//                       // valueIndicatorShape: const RoundSliderOverlayShape(),
//                       // trackHeight: 7.sh(),
//                       // thumbShape:
//                       //     RoundSliderThumbShape(enabledThumbRadius: 8.sr()),
//                       // thumbColor: const Color(0xff9FC6DD))
//                     ),
//                     child: Slider(
//                       label: value.round().toString(),
//                       divisions: widget.isDiscrete
//                           ? (widget.max - widget.min).toInt()
//                           : null,
//                       min: widget.min,
//                       max: widget.max,
//                       activeColor: Theme.of(context).primaryColor,
//                       thumbColor: const Color(0xff9FC6DD),
//                       inactiveColor: lightGrey,
//                       value: value,
//                       onChanged: (val) {
//                         // widget.onChanged(val);
//                         setState(() {
//                           value = val;
//                         });
//                         widget.onChanged(val);
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.sw(),
//                 ),
//                 Text(
//                   widget.max.toInt().toString(),
//                   style: kTextStyleIbmRegular.copyWith(
//                       fontSize: 14.ssp(), color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
