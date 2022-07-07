import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/addshop.dart';
import 'package:videomanager/screens/screenshotmanager/components/fakeshop.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';

class ComponentMaker extends ConsumerWidget {
  ComponentMaker({Key? key}) : super(key: key);
  final double value = 75;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        AddEditShop(
          // shop: shops[0],
          edit: false,
        ),
        Spacer(),
        ShopCard(shop: shops[1])
      ],
    );
  }
}

class VIdeoScreenshot extends StatelessWidget {
  const VIdeoScreenshot({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffE4F4FF),
      child: SizedBox(
        height: 382.sh(),
        // color: Colors.amber,
        child: Column(
          children: [
            SizedBox(
              height: 300.sr(),
              width: 300.sr(),
              child: Stack(
                children: [
                  Center(
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
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.toString(),
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 38.ssp(), color: primaryColor),
                        ),
                        Text(
                          'Out of 100 videos',
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 13.ssp(), color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SfRadialGauge(axes: <RadialAxis>[
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
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 16.sh(),
            ),
            CustomElevatedButton(
                width: 202.96.sw(),
                height: 36.4.sh(),
                onPressedElevated: () {},
                elevatedButtonText: 'View Screenshot')
          ],
        ),
      ),
    );
  }
}
