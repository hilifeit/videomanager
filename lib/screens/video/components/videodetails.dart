import 'package:intl/intl.dart';
import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/utils.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails(
      {Key? key,
      this.showMap = true,
      this.isDetailed = true,
      this.file,
      this.detailedFile,
      this.isFirst = true})
      : super(key: key);
  final bool showMap, isDetailed;
  final FileDetailMini? file;
  final FileDetail? detailedFile;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF8F8F8).withOpacity(!showMap ? 0.95 : 0.8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 31.04.sw(),
                  right: ResponsiveLayout.isDesktop ? 80.05.sw() : 31.04.sw()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (file != null || detailedFile != null)
                    VideoDetailText(
                        title: 'Video Name',
                        details: isDetailed
                            ? detailedFile!.info.filename
                            : file!.filename),
                  if (isDetailed && detailedFile != null)
                    Row(
                      children: [
                        VideoDetailText(
                            title: 'Size',
                            details: formatBytes(detailedFile?.info.size)),
                        SizedBox(
                          width: 21.79.sw(),
                        ),
                        VideoDetailText(
                            title: 'Duration',
                            details: DateFormat("HH:mm:ss")
                                .format(detailedFile!.info.duration)),
                      ],
                    ),
                  if (file != null || detailedFile != null)
                    VideoDetailText(
                      title: 'Path',
                      details: !isDetailed ? file!.path : detailedFile!.path,
                    ),
                  if (isDetailed && detailedFile != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VideoDetailText(
                            title: 'Start Time',
                            details: DateFormat("HH:mm:ss").format(getStartTime(
                                    detailedFile!.info.modifiedDate,
                                    detailedFile!.info.duration)) +
                                "/" +
                                (detailedFile!.info.startTimeLoc != null
                                    ? DateFormat("HH:mm:ss").format(
                                        detailedFile!.info.startTimeLoc!)
                                    : "")),
                        VideoDetailText(
                          title: 'End Time',
                          details: DateFormat("HH:mm:ss")
                                  .format(detailedFile!.info.modifiedDate) +
                              "/" +
                              (detailedFile!.info.endTimeLoc != null
                                  ? DateFormat("HH:mm:ss")
                                      .format(detailedFile!.info.endTimeLoc!)
                                  : ""),
                        ),
                      ],
                    ),
                  if (isDetailed && detailedFile != null)
                    VideoDetailText(
                      title: 'Date',
                      details: DateFormat("EEEE, dd MMMM, y")
                          .format(detailedFile!.info.modifiedDate),
                    ),
                ],
              ),
            ),
          ),
          if (showMap)
            Expanded(
              flex: 2,
              child: Consumer(builder: (context, ref, c) {
                final videoSetting = ref
                    .watch(settingChangeNotifierProvider)
                    .setting
                    .videoSetting;
                final VideoSetting temp =
                    VideoSetting.fromJson(videoSetting.toJson());
                final mapWidget = MapScreen(
                  draw: false,
                  controller: MapController(
                      location: LatLng(detailedFile!.originalLocation.first.lat,
                          detailedFile!.originalLocation.first.lng)),
                  originalData: detailedFile!.originalLocation,
                  isvisible: false,
                  miniMap: false,
                  isFirst: isFirst,
                );
                return Stack(
                  children: [
                    mapWidget,
                    if (temp.allowMinMapFScreen)
                      Positioned(
                          bottom: 5.sh(),
                          right: 5.sw(),
                          child: IconButton(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            child: mapWidget),
                                      );
                                    });
                              },
                              icon: const Icon(Icons.fullscreen)))
                  ],
                );
              }),
            )
        ],
      ),
    );
  }

  DateTime getStartTime(DateTime endTime, DateTime duration) {
    Duration newDuration = Duration(
        hours: duration.hour,
        minutes: duration.minute,
        seconds: duration.second);
    return endTime.subtract(newDuration);
  }
}

class VideoDetailText extends StatelessWidget {
  final String? title;
  final String? details;
  const VideoDetailText({
    Key? key,
    this.title,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '$title:',
            style: kTextStyleInterMedium.copyWith(
                fontSize: 18.ssp(), color: Colors.black.withOpacity(0.8))),
        WidgetSpan(
            child: SizedBox(
          // 21.78
          width: 12.sw(),
        )),
        TextSpan(
            text: '$details', //18
            style: kTextStyleInterMedium.copyWith(fontSize: 15.ssp())),
      ]),
      // '$title : $details',
      // style: kTextStyleInterMedium.copyWith(fontSize: 18.sp),
    );
  }
}
