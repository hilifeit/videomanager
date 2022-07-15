import 'package:map/map.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteritembutton.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/videoassignedcard.dart';
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
          InkWell(
            onTap: () {
              if (CustomOverlayEntry().isMenuOpen) {
                CustomOverlayEntry().closeFilter();
              }
              CustomOverlayEntry().closeVideoBar();
            },
            child: Container(
                width: 30.sw(),
                height: 155.sh(),
                color: const Color(0xffE4F5FF),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              height: size.height,
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
                                    const Spacer(),
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
                                    final fileService = ref
                                        .watch(fileDetailMiniServiceProvider);
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
          ),
        ],
      ),
    );
  }
}
