import 'package:videomanager/screens/components/videosidebar/filteroverlay.dart';
import 'package:videomanager/screens/components/videosidebar/videosidebar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomOverlayEntry {
  static final CustomOverlayEntry _instance = CustomOverlayEntry._internal();

  factory CustomOverlayEntry() => _instance;

  CustomOverlayEntry._internal();

  late OverlayEntry videobar;
  late OverlayEntry loader;
  late OverlayEntry filter;
  late OverlayEntry videotime;
  late BuildContext context;

  bool isMenuOpen = false;
  bool videoBarOpen = false;
  bool videoTimeStampOpen = false;
  bool loaderOpen = false;

  closeVideoBar() {
    videobar.remove();
    videoBarOpen = !videoBarOpen;
  }

  showvideoBar(c, role) {
    if (!videoBarOpen) {
      OverlayState overlayState = Overlay.of(c)!;
      videoSideBarOverlay(c, role);
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
      loader.remove();
      loaderOpen = !loaderOpen;
    });
  }

  showVideoTimeStamp() {
    if (!videoTimeStampOpen) {
      Future.delayed(Duration(milliseconds: 10), () {
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
    if (!isMenuOpen) {
      OverlayState filterState = Overlay.of(c)!;
      filterOverlay(c);
      filterState.insert(filter);
      isMenuOpen = !isMenuOpen;
    }
  }

  closeFilter() {
    Future.delayed(const Duration(milliseconds: 18), () {
      filter.remove();
      isMenuOpen = !isMenuOpen;
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
      return Positioned(
        left: 0,
        bottom: 73.sh(),
        width: size.width,
        height: 203.sh(),
        child: Container(
          height: 203.sh(),
          width: double.infinity,
          color: Colors.amber,
        ),
      );
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
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.sh(), vertical: 15.sw()),
              height: 159.sh(),
              width: 117.sw(),
              child: Consumer(builder: (context, ref, c) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      filterItems.length,
                      (index) => filterItems[index] != filterItems.last
                          ? InkWell(
                              onTap: () {
                                ref.read(filterItemProvider.state).state =
                                    filterItems[index];
                                closeFilter();
                              },
                              child: FilterItemWidget(
                                item: filterItems[index],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                ref.read(filterItemProvider.state).state = null;
                                closeFilter();
                              },
                              child: FilterItemWidget(
                                item: filterItems[index],
                              ),
                            ),
                    ));
              }),
            ),
          ),
        );
      },
    );
  }

  videoSideBarOverlay(BuildContext context, role) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    videobar = OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 73.sh(),
          height: size.height - 73.sh(),
          width: 533.sw(),

          //  top: renderBox.globalToLocal(point),
          child: VideoSideBar(
            role: role,
            size: size,
          ));
    });
  }
}
