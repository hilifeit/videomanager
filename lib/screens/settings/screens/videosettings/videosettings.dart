import 'package:videomanager/screens/others/exporter.dart';
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
          padding: EdgeInsets.only(top: 15.sh(), left: 73.sw()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  SizedBox(
                    width: 200.sw(),
                  ),
                  VideoQualitySelect(
                    value: videoSetting.videoQuality,
                    onChanged: (value) {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
