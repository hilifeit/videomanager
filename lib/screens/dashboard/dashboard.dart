import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:videomanager/screens/components/videoscreenshot/videoscreenshot.dart';
import 'package:videomanager/screens/dashboard/component/assignedVideoCard.dart';
import 'package:videomanager/screens/dashboard/component/outletcard.dart';
import 'package:videomanager/screens/dashboard/component/screenshotreview.dart';
import 'package:videomanager/screens/dashboard/component/targetdard.dart';
import 'package:videomanager/screens/dashboard/component/usercard.dart';
import 'package:videomanager/screens/dashboard/table.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/widgets/widgets.dart';

List<CustomCardItem> items = [
  CustomCardItem(
      height: 139.sh(),
      width: 229.sw(),
      number: 15,
      text: 'Users',
      color: const Color(0xffBADBEF),
      icon: Videomanager.usersoutline),
];

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);
  List<Widget> items = [
    const CustomTable(),
    const VideoScreenshot(value: 100),
    const CustomTable(),
    const CustomTable(),
    const VideoScreenshot(value: 50),
    const CustomTable(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: LayoutBuilder(builder: (context, constraints) {
          return GridView.custom(
              padding: EdgeInsets.all(28.sr()),
              gridDelegate: SliverWovenGridDelegate.count(
                  // crossAxisSpacing: 30.sw(),
                  mainAxisSpacing: 28.sh(),
                  pattern: [
                    if (ResponsiveLayout.isDesktop) ...[
                      const WovenGridTile(1.5,
                          crossAxisRatio: 1,
                          alignment: AlignmentDirectional.center),
                      const WovenGridTile(
                        1.2,
                        crossAxisRatio: 0.75,
                        alignment: AlignmentDirectional.center,
                      ),
                      const WovenGridTile(1.5),
                    ]
                    // else if (ResponsiveLayout.isTablet) ...[
                    //   const WovenGridTile(1.2,
                    //       crossAxisRatio: 1,
                    //       alignment: AlignmentDirectional.center),
                    //   const WovenGridTile(
                    //     1,
                    //     crossAxisRatio: 0.8,
                    //     alignment: AlignmentDirectional.center,
                    //   ),
                    // ]

                    else ...[
                      const WovenGridTile(1.5,
                          crossAxisRatio: 1,
                          alignment: AlignmentDirectional.center),
                    ]
                  ],
                  crossAxisCount: ResponsiveLayout.isDesktop ? 3 : 1),
              childrenDelegate: SliverChildBuilderDelegate(
                  childCount: items.length, (context, index) {
                if (index == 0) {
                  List<Widget> firstItems = [
                    const TargetCard(),
                    const UsersCard(),
                    const OutletCard(),
                    const OutletCard(),
                    const UsersCard(),
                    const ScreenShotReview(),
                    const UsersCard(),
                  ];
                  final ScrollController controller = ScrollController();
                  if (ResponsiveLayout.isMobile) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return Scrollbar(
                        controller: controller,
                        child: ListView.separated(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  child: index == 0
                                      ? firstItems[index]
                                      : Row(
                                          children: [
                                            Expanded(
                                                child: firstItems[index + 1]),
                                            Expanded(
                                                child: firstItems[index + 2])
                                          ],
                                        ));
                            },
                            separatorBuilder: (_, index) {
                              return SizedBox(
                                width: 12.sw(),
                              );
                            },
                            itemCount: 5),
                      );
                    });
                  }
                  return StaggeredGrid.count(
                    crossAxisCount: ResponsiveLayout.isDesktop
                        ? 4
                        : ResponsiveLayout.isTablet
                            ? 3
                            : 2,
                    mainAxisSpacing: 15.sh(),
                    crossAxisSpacing: 15.sh(),
                    children: firstItems.map((e) {
                      if (firstItems.indexOf(e) == 0) {
                        return StaggeredGridTile.count(
                            mainAxisCellCount: 1.25,
                            // mainAxisExtent: 202.sh(),
                            crossAxisCellCount: 2,
                            child: e);
                      }
                      return StaggeredGridTile.fit(
                          // mainAxisCellCount: 1,
                          crossAxisCellCount: 1,
                          child: e);
                    }).toList()
                    // ...List.generate(firstItems.length, (index) {
                    //   if (index == 0) {
                    //     return StaggeredGridTile.count(
                    //         mainAxisCellCount: 1.25,
                    //         // mainAxisExtent: 202.sh(),
                    //         crossAxisCellCount: 2,
                    //         child: firstItems[0]);
                    //   }
                    //   return StaggeredGridTile.fit(
                    //       // mainAxisCellCount: 1,
                    //       crossAxisCellCount: 1,
                    //       child: firstItems[index]);
                    // })
                    ,
                  );
                } else if (index == 4) {
                  return StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.sr(),
                    crossAxisSpacing: 10.sr(),
                    children: [
                      ...List.generate(
                          4,
                          (index) => const StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: AssignedVideoCard()))
                    ],
                  );
                }
                return items[index];
              }));
        }));
  }
}
