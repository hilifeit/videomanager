import 'package:videomanager/screens/others/exporter.dart';
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
                'Video URl',
                style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
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
                  VideoQualitySelect()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoQualityItem {
  VideoQualityItem({required this.text, required this.id});
  String text;
  int id;
}

List<VideoQualityItem> items = [
  VideoQualityItem(text: '120p', id: 0),
  VideoQualityItem(text: '360p', id: 1),
  VideoQualityItem(text: '720p', id: 2),
  VideoQualityItem(text: '1080p', id: 3),
];

class VideoQualitySelect extends StatelessWidget {
  VideoQualitySelect({
    Key? key,
    //required this.item,
  }) : super(key: key);
  //final VideoQualityItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: 106.sw(),
          height: 49.sh(),
          decoration: BoxDecoration(
              color: lightWhite.withOpacity(0.22),
              borderRadius: BorderRadius.circular(4.sr())),
          child: Center(
            child: Text(
              '120p',
            ),
          ),
        ));
  }
}
