import 'package:videomanager/screens/dashboard/component/filemodelsource.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteritembutton.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filteroverlay.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/filterservice.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/videosidebar.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/timeline/timeline.dart';
import 'package:videomanager/screens/viewscreen/services/filterService.dart';

class CustomOverlayEntry {
  static final CustomOverlayEntry _instance = CustomOverlayEntry._internal();

  factory CustomOverlayEntry() => _instance;

  CustomOverlayEntry._internal();

  late OverlayEntry videobar;
  late OverlayEntry loader;
  late OverlayEntry filter;
  late OverlayEntry videotime;
  late BuildContext context;
  late OverlayEntry logout;

  bool isFilterMenuOpen = false;
  bool videoBarOpen = false;
  bool videoTimeStampOpen = false;
  bool loaderOpen = false;

  closeVideoBar() {
    videobar.remove();
    videoBarOpen = !videoBarOpen;
  }

  showvideoBar(c, thisUser) {
    if (!videoBarOpen) {
      OverlayState overlayState = Overlay.of(c)!;
      videoSideBarOverlay(c, thisUser);
      overlayState.insert(videobar);
      videoBarOpen = !videoBarOpen;
    }
  }

  showLoader() {
    if (!loaderOpen) {
      Future.delayed(const Duration(milliseconds: 15), () {
        OverlayState state = Overlay.of(context)!;
        loader = progressIndicatorOverlay(context);
        state.insert(loader);
        loaderOpen = !loaderOpen;
      });
    }
  }

  closeLoader() {
    Future.delayed(const Duration(milliseconds: 18), () {
      if (loaderOpen) {
        loader.remove();
        loaderOpen = !loaderOpen;
      }
    });
  }

  showVideoTimeStamp() {
    if (!videoTimeStampOpen) {
      Future.delayed(const Duration(milliseconds: 10), () {
        OverlayState timeState = Overlay.of(context)!;
        videoTimeStamp(context);
        timeState.insert(videotime);
        videoTimeStampOpen = !videoTimeStampOpen;
      });
    }
  }

  closeVideoTimeStamp() {
    videotime.remove();
    videoTimeStampOpen = !videoTimeStampOpen;
  }

  showFilter(BuildContext c) {
    if (!isFilterMenuOpen) {
      OverlayState filterState = Overlay.of(c)!;
      filterOverlay(c);
      filterState.insert(filter);
      isFilterMenuOpen = !isFilterMenuOpen;
    }
  }

  closeFilter() {
    Future.delayed(const Duration(milliseconds: 18), () {
      filter.remove();
      isFilterMenuOpen = !isFilterMenuOpen;
    });
  }

  progressIndicatorOverlay(BuildContext context) {
    return OverlayEntry(builder: ((context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }));
  }

  videoTimeStamp(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    videotime = OverlayEntry(builder: ((context) {
      return Timeline(size: size);
    }));
  }

  filterOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    late Offset buttonPosition;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
    var size = renderBox.size;
    filter = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + size.height + 2.sh(),
          left: buttonPosition.dx - 117.sw() + size.width,
          child: Material(
            child: SizedBox(
              height: 159.sh(),
              width: 117.sw(),
              child: Consumer(builder: (context, ref, c) {
                final filterItems =
                    ref.watch(filterModuleServiceProvider).filterItems;

                return Consumer(builder: (context, ref, c) {
                  final filterService = ref.watch(filterModuleServiceProvider);
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          filterItems.length,
                          (index) => InkWell(
                                onTap: () {
                                  filterService.addItems(index);
                                },
                                child: FilterItemWidget(
                                  item: filterItems[index],
                                ),
                              )));
                });
              }),
            ),
          ),
        );
      },
    );
  }

  logoutOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    late Offset buttonPosition;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
    var size = renderBox.size;
    logout = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + size.height + 2.sh(),
          left: buttonPosition.dx - 117.sw() + size.width,
          child: Material(
              child: CustomPopUpMenuItemChild(
                  icon: Videomanager.logout, text: 'Logout')),
        );
      },
    );
  }

  videoSideBarOverlay(BuildContext context, thisUser) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    videobar = OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 0,
          height: size.height,
          width: 560.sw(),

          //  top: renderBox.globalToLocal(point),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isFilterMenuOpen) {
                closeFilter();
              }
            },
            child: VideoSideBar(
              thisUser: thisUser,
            ),
          ));
    });
  }
}
