import 'package:map/map.dart';
import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteritembutton.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filterservice.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/userstatswrap.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/videoassignedcard.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotDashboardHolder.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class VideoSideBar extends StatelessWidget {
  VideoSideBar({Key? key, required this.thisUser}) : super(key: key);

  final UserModelMini thisUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          if (ResponsiveLayout.isDesktop)
            Consumer(builder: (context, ref, c) {
              return InkWell(
                onTap: () {
                  if (CustomOverlayEntry().isFilterMenuOpen) {
                    CustomOverlayEntry().closeFilter();
                  }
                  // CustomOverlayEntry().closeVideoBar();
                  ref.read(showVideoBarProvider.state).state = false;
                },
                child: Container(
                    width: 30.sw(),
                    height: 155.sh(),
                    color: const Color(0xffE4F5FF),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                    )),
              );
            }),
          Expanded(
            child: Container(
              color: Colors.white,
              height: double.infinity,
              child: Column(
                children: [
                  thisUser.role == 0
                      ? Expanded(
                          flex: ResponsiveLayout.isDesktop
                              ? 3
                              : ResponsiveLayout.isTablet
                                  ? 2
                                  : 4,
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
                            draw: true,
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
                              final fileService =
                                  ref.watch(fileDetailMiniServiceProvider);

                              final files = [];

                              final selectedFilter = ref
                                  .watch(filterModuleServiceProvider)
                                  .selectedItems;
                              final areas = ref
                                  .watch(fileDetailMiniServiceProvider)
                                  .areas;
                              final selectedArea = ref
                                  .watch(selectedAreaServiceProvider)
                                  .selectedArea
                                  .value;

                              if (thisUser.role == Roles.manager.index &&
                                  selectedArea != null) {
                                files.addAll(ref
                                    .read(selectedAreaServiceProvider)
                                    .refinedSelection
                                    .value);
                              } else if (thisUser.role == Roles.user.index) {
                                files.clear();
                                files.addAll(fileService.userFiles!);
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (thisUser.role == Roles.manager.index) ...[
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
                                    // if (areas != [])
                                    Wrap(
                                      children: List.generate(
                                        areas.length,
                                        (index) => Padding(
                                            padding:
                                                EdgeInsets.only(right: 16.sw()),
                                            child: AreaCard(
                                                area: areas[index],
                                                selected: selectedArea != null
                                                    ? selectedArea ==
                                                        areas[index]
                                                    : false)),
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
                                  files.isEmpty
                                      ? Center(
                                          child: Text("Select Area"),
                                        )
                                      : Expanded(
                                          child: selectedFilter.isNotEmpty
                                              ? ListView.separated(
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (selectedFilter.contains(
                                                        files[index]
                                                            .status
                                                            .status)) {
                                                      return VideoAssignCard(
                                                        item: files[index],
                                                        thisUser: thisUser,
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      height: 8.sh(),
                                                    );
                                                  },
                                                  itemCount: files.length)
                                              : ListView.separated(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return VideoAssignCard(
                                                      item: files[index],
                                                      thisUser: thisUser,
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
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
