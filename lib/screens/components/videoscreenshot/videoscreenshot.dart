import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:videomanager/screens/others/exporter.dart';

class VideoScreenshot extends StatelessWidget {
  const VideoScreenshot({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffE4F4FF),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  // color: Colors.grey.withOpacity(0.5),
                  child: Gauge(value: value),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value.toString(),
                        style: kTextStyleIbmSemiBold.copyWith(
                            fontSize: 28.ssp(), color: primaryColor),
                      ),
                      Text(
                        'Out of 100 videos',
                        style: kTextStyleIbmSemiBold.copyWith(
                            fontSize: 13.ssp(), color: primaryColor),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: 20.sh(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total Sxcreen taken out of',
                        style: kTextStyleIbmSemiBold.copyWith(
                            fontSize: 13..ssp(),
                            color: const Color(0xffA1ACB8)),
                      ),
                      Text('100 videos',
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 13..ssp(),
                              color: const Color(0xff697A8D)))
                    ],
                  ),
                ),
              ],
            ),
          ),

          // const Spacer(),

          CustomElevatedButton(
              width: 202.96.sw(),
              height: 36.4.sh(),
              onPressedElevated: () {},
              elevatedButtonText: 'View Screenshot'),
          SizedBox(
            height: 30.sh(),
          )
        ],
      ),
    );
  }
}

class Gauge extends StatelessWidget {
  const Gauge({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      // Create primary radial axis
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        startAngle: 138,
        endAngle: 42,
        radiusFactor: 0.7,
        axisLineStyle: const AxisLineStyle(
          thickness: 0,
          // color: Color.fromARGB(30, 0, 169, 181),
          // thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers: <GaugePointer>[
          RangePointer(
            color: primaryColor,
            value: value,
            width: 0.15,
            pointerOffset: 0.07,
            sizeUnit: GaugeSizeUnit.factor,
          )
        ],
      ),
      RadialAxis(
        minimum: 0,
        interval: 1,
        maximum: 40,
        showLabels: false,
        showTicks: true,
        showAxisLine: false,
        tickOffset: 0.07,
        offsetUnit: GaugeSizeUnit.factor,
        minorTicksPerInterval: 0,
        startAngle: 138,
        endAngle: 42,
        radiusFactor: 0.7,
        majorTickStyle: const MajorTickStyle(
            length: 0.15,
            thickness: 3,
            lengthUnit: GaugeSizeUnit.factor,
            color: Color(0xffE4F4FF)),
      ),
    ]);
  }
}
