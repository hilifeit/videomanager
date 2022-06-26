import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails(
      {Key? key, this.showMap = true, this.isDetailed = true, this.miniDetail})
      : super(key: key);
  final bool showMap, isDetailed;
  final FileDetailMini? miniDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF8F8F8).withOpacity(!showMap ? 0.95 : 0.8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 31.04.sw(), right: 80.05.sw()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoDetailText(
                      title: 'Video Name',
                      details: !isDetailed
                          ? miniDetail != null
                              ? miniDetail!.filename
                              : ''
                          : ''),
                  if (miniDetail == null)
                    Row(
                      children: [
                        const VideoDetailText(title: 'Size', details: '1.2GB'),
                        SizedBox(
                          width: 21.79.sw(),
                        ),
                        const VideoDetailText(
                            title: 'Duration', details: '00:05:00'),
                      ],
                    ),
                  VideoDetailText(
                    title: 'Path',
                    details: !isDetailed
                        ? miniDetail != null
                            ? miniDetail!.path
                            : ''
                        : '',
                  ),
                  if (miniDetail == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        VideoDetailText(
                          title: 'Start Time',
                          details: '00:05:00',
                        ),
                        VideoDetailText(
                          title: 'End Time',
                          details: '00:11:00',
                        ),
                      ],
                    ),
                  if (miniDetail == null)
                    const VideoDetailText(
                      title: 'Date',
                      details: '2072-12-13',
                    ),
                ],
              ),
            ),
          ),
          if (showMap)
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MapScreen(
                    draw: false,
                    controller: MapController(location: home),
                    isvisible: false,
                    miniMap: false,
                  ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        child: MapScreen(
                                          miniMap: true,
                                          controller:
                                              MapController(location: home),
                                        )),
                                  );
                                });
                          },
                          icon: const Icon(Icons.fullscreen)))
                ],
              ),
            )
        ],
      ),
    );
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
          width: 21.79.sw(),
        )),
        TextSpan(
            text: '$details',
            style: kTextStyleInterMedium.copyWith(fontSize: 18.ssp())),
      ]),
      // '$title : $details',
      // style: kTextStyleInterMedium.copyWith(fontSize: 18.sp),
    );
  }
}
