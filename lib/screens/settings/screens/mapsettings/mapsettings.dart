import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

import 'package:videomanager/screens/video/components/videodetails.dart';

class MapSettings extends ConsumerWidget {
  MapSettings({Key? key, required this.mapSetting}) : super(key: key);
  final MapSetting mapSetting;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    TextWithSlider(
                      text: 'Zoom Factor',
                      max: '0',
                      min: '10',
                      value: mapSetting.zoom,
                    ),
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
                      style:
                          kTextStyleInterRegular.copyWith(fontSize: 22.ssp()),
                    ),
                    SizedBox(
                      height: 18.sh(),
                    ),
                    TextWithSlider(
                      text: 'Original Map Quality',
                      min: '120',
                      max: '720',
                      value: mapSetting.sample.original.toDouble(),
                    ),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    TextWithSlider(
                        text: 'View Map Quality',
                        max: '120',
                        min: '720',
                        value: mapSetting.sample.view.toDouble()),
                    SizedBox(
                      height: 33.sh(),
                    ),
                    TextWithSlider(
                      text: 'Original Mini Map Quality',
                      max: '120',
                      min: '720',
                      value: mapSetting.sample.miniMap.toDouble(),
                    ),
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
                              value: mapSetting.defaultLocation.enabled,
                              onChanged: (valueS) {}),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 22.sh(),
                    ),
                    if (mapSetting.defaultLocation.enabled) ...[
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
                              VideoDetailText(
                                title: 'Latitude',
                                details:
                                    mapSetting.defaultLocation.lat.toString(),
                              ),
                              SizedBox(width: 11.sw()),
                              VideoDetailText(
                                title: 'Longitutde',
                                details:
                                    mapSetting.defaultLocation.lng.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 23.sh(),
                      ),
                    ],
                    TextWithSlider(
                      text: 'Suggestion / Result Count',
                      max: '50',
                      min: '500',
                      value: mapSetting.filterCount.toDouble(),
                    ),
                    SizedBox(
                      height: 23.sh(),
                    ),
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
                          onPressed: () {
                            // var settingService =
                            //     ref.read(settingChangeNotifierProvider);
                            // settingService.updateSetting(
                            //     mapSetting: mapSetting..filterCount = 0);
                          },
                          child: Text(
                            'Apply',
                            style: kTextStyleIbmMedium.copyWith(
                                color: Colors.white, fontSize: 17.ssp()),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 120.sh()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithSlider extends StatefulWidget {
  TextWithSlider({
    Key? key,
    required this.text,
    required this.min,
    required this.max,
    required this.value,
  }) : super(key: key);
  final String text;
  final String min;
  final String max;
  final double value;

  @override
  State<TextWithSlider> createState() => _TextWithSliderState();
}

class _TextWithSliderState extends State<TextWithSlider> {
  double value = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  value = widget.value;
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
                  widget.min,
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
                        thumbColor: const Color(0xff9FC6DD)),
                    child: Slider(
                      activeColor: Theme.of(context).primaryColor,
                      thumbColor: const Color(0xff9FC6DD),
                      inactiveColor: lightWhite,
                      value: widget.value,
                      onChanged: (val) {
                        // widget.onChanged(val);
                        setState(() {
                          value = val;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  widget.max,
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
