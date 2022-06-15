import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF8F8F8).withOpacity(0.8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 31.04.w, right: 108.05.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VideoDetailText(
                      title: 'Video Name', details: 'Kupondole_left.mp4'),
                  Row(
                    children: [
                      const VideoDetailText(title: 'Size', details: '1.2GB'),
                      SizedBox(
                        width: 21.79.w,
                      ),
                      const VideoDetailText(
                          title: 'Duration', details: '00:05:00'),
                    ],
                  ),
                  const VideoDetailText(
                    title: 'Path',
                    details: 'adjadnad',
                  ),
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
                  const VideoDetailText(
                    title: 'Date',
                    details: '2072-12-13',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                MapScreen(
                  controller: MapController(location: home),
                  isvisible: false,
                ),
                Positioned(
                    bottom: 5.h,
                    right: 5.w,
                    child: IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  content: SizedBox(
                                      // width: 1.sw,
                                      child: MapScreen(
                                    controller: MapController(location: home),
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
                fontSize: 18.sp, color: Colors.black.withOpacity(0.8))),
        WidgetSpan(
            child: SizedBox(
          width: 21.79.w,
        )),
        TextSpan(
            text: '$details',
            style: kTextStyleInterMedium.copyWith(fontSize: 18.sp)),
      ]),
      // '$title : $details',
      // style: kTextStyleInterMedium.copyWith(fontSize: 18.sp),
    );
  }
}
