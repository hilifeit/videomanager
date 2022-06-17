import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/components/outlineandelevatedbutton.dart';
import 'package:videomanager/screens/settings/screens/videosettings/components/videoqualityselect.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';

class VideoSettings extends ConsumerWidget {
  const VideoSettings({required this.videoSetting, Key? key}) : super(key: key);
  final VideoSetting videoSetting;

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
                height: 39.sh(),
              ),
              Text(
                'Video Server Url',
                style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
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
                    onChanged: (value) {},
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
                  onChanged: (val) {}),
              SizedBox(
                height: 56.36.sh(),
              ),
              CustomSwitch(
                value: videoSetting.videoFScreen,
                onChanged: (val) {},
                text: 'Video In Full Screen ',
                space: 603.sw(),
              ),
              SizedBox(
                height: 55.sh(),
              ),
              OutlineAndElevatedButton(
                onApply: () {},
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
