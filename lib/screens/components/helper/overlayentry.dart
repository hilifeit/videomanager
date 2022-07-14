import 'package:videomanager/screens/components/videosidebar/filteroverlay.dart';
import 'package:videomanager/screens/components/videosidebar/videosidebar.dart';
import 'package:videomanager/screens/others/exporter.dart';

class CustomREctClipper extends CustomClipper<Path> {
  CustomREctClipper({
    required this.bigWidth,
    required this.bigHeight,
    required this.smallWidth,
    required this.smallHeight,
    required this.bigleft,
    required this.bigtop,
  });
  final double bigWidth, bigHeight, smallWidth, smallHeight, bigleft, bigtop;

  @override
  getClip(Size size) {
    // TODO: implement getClip

    Path path = Path();

    path.addRect(Rect.fromLTWH(
      bigleft,
      bigHeight / 2 - smallHeight / 2,
      smallWidth,
      smallHeight,
    ));
    path.addRect(Rect.fromLTWH(bigleft, bigtop, bigWidth, bigHeight));

    // path.addOval(Rect.fromCircle(center: Offset(left, top), radius: radius));
    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width / 2, size.height / 2),
    //     radius: size.width / 2));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class CustomOverlayEntry {
  static final CustomOverlayEntry _instance = CustomOverlayEntry._internal();

  factory CustomOverlayEntry() => _instance;

  CustomOverlayEntry._internal();

  late OverlayEntry overlay;
  late OverlayEntry loader;
  late OverlayEntry filter;
  late BuildContext context;

  bool isMenuOpen = false;
  closeVideoBar() {
    overlay.remove();
  }

  showvideoBar(c, role) {
    OverlayState overlayState = Overlay.of(c)!;
    createOverlay(c, role);
    overlayState.insert(overlay);
  }

  showLoader() {
    Future.delayed(const Duration(milliseconds: 15), () {
      OverlayState state = Overlay.of(context)!;
      loader = progressIndicatorOverlay(context);
      state.insert(loader);
    });
  }

  closeLoader() {
    Future.delayed(const Duration(milliseconds: 18), () {
      loader.remove();
    });
  }

  showFilter(BuildContext c) {
    OverlayState filterState = Overlay.of(c)!;
    filterOverlay(c);
    filterState.insert(filter);
    isMenuOpen = !isMenuOpen;
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

  createOverlay(BuildContext context, role) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    overlay = OverlayEntry(builder: (context) {
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
