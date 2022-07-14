import 'package:map/map.dart';
import 'package:videomanager/screens/components/clippedholder.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/videosidebar/filteroverlay.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/component/userstats.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class VideoSideBar extends StatelessWidget {
  VideoSideBar({Key? key, required this.size, required this.role})
      : super(key: key);
  final Size size;
  final int role;

  List<VideoAssignCardItems> items = [
    VideoAssignCardItems(
        fileName: "rapa", screenShot: 451, shops: 2150, status: 'Pending'),
    VideoAssignCardItems(
        fileName: "bagmati", screenShot: 155, shops: 52, status: 'Approved'),
    VideoAssignCardItems(
        fileName: "gandaki", screenShot: 144, shops: 5555, status: 'Complete'),
    VideoAssignCardItems(
        fileName: "daada", screenShot: 451, shops: 55, status: 'Rejected'),
    VideoAssignCardItems(
        fileName: "rapaddti", screenShot: 451, shops: 211, status: 'Ongoing'),
    VideoAssignCardItems(
        fileName: "rapaddti", screenShot: 451, shops: 211, status: 'Ongoing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          ClipPath(
            clipper: CustomREctClipper(
                bigHeight: size.height - 73.sh(),
                bigWidth: 30.sw(),
                bigleft: 0,
                bigtop: 0,
                smallHeight: 155.sh(),
                smallWidth: 30.sw()),
            child: InkWell(
              onTap: () {
                if (CustomOverlayEntry().isMenuOpen) {
                  CustomOverlayEntry().closeFilter();
                }
                CustomOverlayEntry().closeVideoBar();
              },
              child: Container(
                  width: 30.sw(),
                  height: 155.sh(),
                  color: Color(0xffE4F5FF),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                  )),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     closeOverlay();
          //   },
          //   child: Container(
          //       width: 30.sw(),
          //       height: 155.sh(),
          //       color: Color(0xffE4F5FF),
          //       child: Icon(
          //         Icons.chevron_right_rounded,
          //         color: Colors.black,
          //       )),
          // ),
          Container(
            color: Colors.white,
            height: size.height,
            width: 503.sw(),
            child: Column(
              children: [
                role == 0
                    ? Expanded(child: UserStats())
                    : Expanded(
                        // height: size.height - 535.sh(),
                        child: MapScreen(
                          isvisible: false,
                          draw: false,
                          controller: MapController(location: home),
                        ),
                      ),
                SizedBox(
                  height: 5.sh(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 37.sw(), right: 37.sw(), bottom: 0.sh()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 480.sh(),
                        child: Consumer(builder: (context, ref, c) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Videos',
                                    style: kTextStyleIbmMedium.copyWith(
                                      fontSize: 18.ssp(),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  FilterIconButton(),

                                  //     ),
                                ],
                              ),
                              SizedBox(
                                height: 13.sh(),
                              ),
                              Expanded(
                                child: Consumer(builder: (context, ref, c) {
                                  final thisUser = ref
                                      .watch(userChangeProvider)
                                      .loggedInUser
                                      .value;
                                  final fileService =
                                      ref.watch(fileDetailMiniServiceProvider);
                                  final files = fileService.userFiles;
                                  return ListView.separated(
                                      itemBuilder: (context, index) {
                                        return VideoAssignCard(
                                          item: files[index],
                                          thisUser: thisUser!,
                                        );
                                      },
                                      separatorBuilder: (context, _) {
                                        return SizedBox(
                                          height: 8.sh(),
                                        );
                                      },
                                      itemCount: files.length);
                                }),
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final filterItemProvider = StateProvider<FilterItemWidgetItem?>((ref) {
  return null;
});

class FilterIconButton extends ConsumerWidget {
  FilterIconButton({Key? key}) : super(key: key);

  final FocusNode foucusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterSelect = ref.watch(filterItemProvider.state).state;
    return InkWell(
      onTap: () {
        if (CustomOverlayEntry().isMenuOpen) {
          CustomOverlayEntry().closeFilter();
        } else {
          CustomOverlayEntry().showFilter(context);
        }
      },
      child: Row(
        children: [
          if (filterSelect != null)
            Padding(
              padding: EdgeInsets.only(right: 5.sw()),
              child: Container(
                  padding: EdgeInsets.all(
                    7.sw(),
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: FilterItemWidget(item: filterSelect)),
            ),
          Container(
            padding: EdgeInsets.all(10.sr()),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4.sr())),
            child:
                Icon(Videomanager.filter, color: Colors.white, size: 18.ssp()),
          ),
        ],
      ),
    );
  }
}
