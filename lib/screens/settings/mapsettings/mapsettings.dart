import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';

class MapsSettings extends ConsumerWidget {
  const MapsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.sh(), left: 81.sw()),
            child: Text(
              'Map Settings',
              style: kTextStyleInterSemiBold.copyWith(
                  fontSize: 21.ssp(), color: primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
            child: Container(
              width: 816.sw(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWithSlider(
                      text: 'Zoom Factor', max: '0', min: '10'),
                  SizedBox(
                    height: 23.sh(),
                  ),
                  const TextWithDDownButton(text: 'Stroke Width'),
                  SizedBox(
                    height: 23.sh(),
                  ),
                  const TextWithDDownButton(text: 'Scroll Zoom in'),
                  SizedBox(
                    height: 23.sh(),
                  ),
                  Text(
                    'Sample Quality',
                    style: kTextStyleInterRegular.copyWith(fontSize: 22.ssp()),
                  ),
                  SizedBox(
                    height: 18.sh(),
                  ),
                  const TextWithSlider(
                      text: 'Original Map Quality', min: '120', max: '720'),
                  SizedBox(
                    height: 33.sh(),
                  ),
                  const TextWithSlider(
                      text: 'View Map Quality', max: '120', min: '720'),
                  SizedBox(
                    height: 56.sh(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Map Default Location',
                        style: kTextStyleInterRegular.copyWith(
                            fontSize: 16.ssp(), color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 7.sw()),
                        child: Switch(
                            activeColor: Theme.of(context).primaryColor,
                            value: true,
                            onChanged: (valueS) {}),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 22.sh(),
                  ),
                  Container(
                    width: 816.sw(),
                    height: 49.sh(),
                    decoration: BoxDecoration(
                        color: lightWhite.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(4.sr())),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 32.sw(),
                        top: 14.sh(),
                        bottom: 14.sh(),
                      ),
                      child: Row(
                        children: [
                          const VideoDetailText(
                            title: 'Latitude',
                            details: '75.55',
                          ),
                          SizedBox(width: 11.sw()),
                          const VideoDetailText(
                            title: 'Longitutde',
                            details: '75.55',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23.sh(),
                  ),
                  const TextWithSlider(
                      text: 'Suggestion / Result Count', max: '0', min: '500'),
                  SizedBox(
                    height: 23.sh(),
                  ),
                  const TextWithSlider(
                      text: 'Original Mini Map Quality',
                      max: '120',
                      min: '720'),
                  SizedBox(
                    height: 96.sh(),
                  ),
                  Row(children: [
                    Container(
                      width: 126.sw(),
                      height: 46.sh(),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sr()),
                          border: Border.all(color: Colors.black)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: kTextStyleIbmMedium.copyWith(
                                color: Colors.black, fontSize: 17.ssp()),
                          )),
                    ),
                    SizedBox(
                      width: 60.sw(),
                    ),
                    SizedBox(
                      width: 126.sw(),
                      height: 46.sh(),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor)),
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          style: kTextStyleIbmMedium.copyWith(
                              color: Colors.white, fontSize: 17.ssp()),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithSlider extends StatelessWidget {
  const TextWithSlider({
    Key? key,
    required this.text,
    required this.min,
    required this.max,
  }) : super(key: key);
  final String text;
  final String min;
  final String max;

  @override
  Widget build(BuildContext context) {
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
                  min,
                  style: kTextStyleIbmRegular.copyWith(
                      fontSize: 14.ssp(), color: Colors.black),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 7.sh(),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.sr()),
                            thumbColor: const Color(0xff9FC6DD)
                            ),
                    child: Slider(
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: lightWhite,
                      value: 0.2,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Text(
                  max,
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

class TextWithDDownButton extends StatelessWidget {
  const TextWithDDownButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.sw(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
          ),
          Placeholder(fallbackWidth: 106.sw(), fallbackHeight: 49.sh()),
        ],
      ),
    );
  }
}
