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
        backgroundColor: Colors.amber,
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
                        crossAxisRatio: 0.65,
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
                  return StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15.sh(),
                    crossAxisSpacing: 15.sh(),
                    children: [
                      const StaggeredGridTile.count(
                          mainAxisCellCount: 1.25,
                          // mainAxisExtent: 202.sh(),
                          crossAxisCellCount: 2,
                          child: TargetCard()),
                      const StaggeredGridTile.fit(
                          // mainAxisCellCount: 1,
                          crossAxisCellCount: 1,
                          child: UsersCard()),
                      ...List.generate(
                        3,
                        (index) => const StaggeredGridTile.fit(
                            // mainAxisCellCount: 1,
                            crossAxisCellCount: 1,
                            child: OutletCard()),
                      ),
                      ...List.generate(
                        2,
                        (index) => const StaggeredGridTile.fit(
                            // mainAxisCellCount: 1,
                            crossAxisCellCount: 1,
                            child: ScreenShotReview()),
                      )
                    ],
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
                              // mainAxisCellCount: 1,
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
