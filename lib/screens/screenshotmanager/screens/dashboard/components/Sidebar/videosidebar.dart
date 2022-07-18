import 'package:map/map.dart';
import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteritembutton.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filterservice.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/userstatswrap.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/videoassignedcard.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class VideoSideBar extends StatelessWidget {
  VideoSideBar({Key? key, required this.size, required this.thisUser})
      : super(key: key);
  final Size size;

  final UserModelMini thisUser;
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
              if (CustomOverlayEntry().isFilterMenuOpen) {
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
                  thisUser.role == 0
                      ? Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 37.sw(), vertical: 10.sh()),
                            child: UserStatsWrap(),
                          ),
                        )
                      : Expanded(
                          flex: 3,
                          // height: size.height - 535.sh(),
                          child: MapScreen(
                            isvisible: false,
                            draw: false,
                            controller: MapController(location: home),
                          ),
                        ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.sw(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Consumer(builder: (context, ref, c) {
                              // final thisUser = ref
                              //     .watch(userChangeProvider)
                              //     .loggedInUser
                              //     .value;
                              final fileService =
                                  ref.watch(fileDetailMiniServiceProvider);
                              final files = fileService.userFiles;
                              final filterService =
                                  ref.watch(filterModuleServiceProvider);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (thisUser.role == 1) ...[
                                    Text(
                                      'Assigned Area',
                                      style: kTextStyleIbmMedium.copyWith(
                                        fontSize: 18.ssp(),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.sh(),
                                    ),
                                    Wrap(
                                      children: List.generate(
                                        areaItems.length,
                                        (index) => InkWell(
                                          onTap: () {},
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 16.sw()),
                                              child: AreaCard(
                                                item: areaItems[index],
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 44.sh(),
                                    ),
                                  ],
                                  Text(
                                    'Videos',
                                    style: kTextStyleIbmMedium.copyWith(
                                      fontSize: 18.ssp(),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.sh(),
                                  ),
                                  FilterIconButton(),
                                  SizedBox(
                                    height: 13.sh(),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return VideoAssignCard(
                                            item: files[index],
                                            thisUser: thisUser,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: 8.sh(),
                                          );
                                        },
                                        itemCount: files.length),
                                  ),
                                  if (thisUser.role == 1) ...[
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CustomElevatedButton(
                                          icon: Videomanager
                                              .add_user_svgrepo_com_1,
                                          onPressedElevated: () {},
                                          elevatedButtonText: 'Assign'),
                                    ),
                                    SizedBox(
                                      height: 23.sh(),
                                    ),
                                  ],
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
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
