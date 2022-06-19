import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/videosettings/components/videoqualityselect.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

class VideoSettings extends ConsumerWidget {
  VideoSettings({required this.videoSetting, Key? key}) : super(key: key);
  final VideoSetting videoSetting;
  late VideoSetting temp = VideoSetting.fromJson(videoSetting.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 43.sh(), left: 73.sw()),
          child: SizedBox(
            // width: MediaQuery.of(context).size.width * .35,
            width: 816.sw(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Video Settings',
                style: kTextStyleInterSemiBold.copyWith(
                    fontSize: 21.ssp(), color: primaryColor),
              ),
              SizedBox(
                height: 12.sh(),
              ),
              Row(
                children: [
                  Text(
                    'Video Server Url',
                    style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
                  ),
                  const Spacer(),
                  Text(
                    'http://  ',
                    style: kTextStyleIbmSemiBold.copyWith(
                        fontSize: 18.ssp(), color: secondaryColorText),
                  ),
                  Expanded(
                      flex: 2,
                      child: InputTextField(
                          value: videoSetting.videourl,
                          style: kTextStyleIbmSemiBold.copyWith(
                              fontSize: 18.ssp(), color: Colors.black),
                          title: 'title',
                          isVisible: false)),
                ],
              ),
              SizedBox(
                height: 39.sh(),
              ),
              Row(
                children: [
                  Text(
                    'Stream Quality',
                    style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
                  ),
                  const Spacer(),
                  VideoQualitySelect(
                    value: videoSetting.videoQuality,
                    onChanged: (val) {
                      temp.videoQuality = val;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 44.sh(),
              ),
              CustomSwitch(
                  text: 'Allow Mini Map In Full Screen',
                  space: 535.sw(),
                  value: videoSetting.allowMinMapFScreen,
                  onChanged: (val) {
                    temp.allowMinMapFScreen = val;
                  }),
              SizedBox(
                height: 56.36.sh(),
              ),
              CustomSwitch(
                value: videoSetting.videoFScreen,
                onChanged: (val) {
                  temp.videoFScreen = val;
                },
                text: 'Video In Full Screen ',
                space: 603.sw(),
              ),
              SizedBox(
                height: 55.sh(),
              ),
              OutlineAndElevatedButton(
                onApply: () {
                  var setting = ref.read(settingChangeNotifierProvider);

                  setting.updateSetting(videoSetting: temp);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
