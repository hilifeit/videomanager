import 'package:videomanager/screens/components/videosidebar/videosidebar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';

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
  closeOverlay() {
    overlay.remove();
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
                                filter.remove();
                              },
                              child: FilterItemWidget(
                                item: filterItems[index],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                ref.read(filterItemProvider.state).state = null;
                                filter.remove();
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

  createOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    overlay = OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 73.sh(),
          height: size.height - 73.sh(),
          width: 533.sw(),

          //  top: renderBox.globalToLocal(point),
          child: VideoSideBAr(
            size: size,
          ));
    });
  }
}

final filterItemProvider = StateProvider<FilterItemWidgetItem?>((ref) {
  return null;
});

class FilterIconButton extends ConsumerStatefulWidget {
  const FilterIconButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterIconButtonState();
}

class _FilterIconButtonState extends ConsumerState<FilterIconButton> {
  bool isMenuOpen = false;

  late Offset buttonPosition;
  final FocusNode foucusNode = FocusNode();

  late OverlayEntry overlayEntry;

  // void closeMenu() {
  //   overlayEntry.remove();
  //   isMenuOpen = !isMenuOpen;
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   foucusNode.addListener(() {
  //     if (!foucusNode.hasFocus) {
  //       closeMenu();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(7.sr()),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(4.sr())),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Videomanager.filter, color: Colors.white),
            onPressed: () {
              if (isMenuOpen) {
                CustomOverlayEntry().filter.remove();
                isMenuOpen = !isMenuOpen;
              } else {
                OverlayState overlayState = Overlay.of(context)!;
                CustomOverlayEntry().filterOverlay(context);
                overlayState.insert(CustomOverlayEntry().filter);
                isMenuOpen = !isMenuOpen;
              }
            },
          ),
        ],
      ),
    );
  }
}

class FilterItemWidgetItem {
  FilterItemWidgetItem({required this.icon, required this.text});
  final String text;
  final Widget icon;
}

List<FilterItemWidgetItem> filterItems = [
  FilterItemWidgetItem(
      icon: Icon(
        Videomanager.pending,
        color: Colors.black,
        size: 14.88.ssp(),
      ),
      text: 'Pending'),
  FilterItemWidgetItem(
      icon: Icon(
        Icons.done,
        color: Colors.black,
        size: 14.88.ssp(),
      ),
      text: 'Complete'),
  FilterItemWidgetItem(
      icon: Icon(
        Videomanager.ongoing,
        color: Colors.black,
        size: 14.88.ssp(),
      ),
      text: 'Ongoing'),
  FilterItemWidgetItem(
    icon: Icon(
      Videomanager.complete,
      color: Colors.black,
      size: 14.88.ssp(),
    ),
    text: 'Approved',
  ),
  FilterItemWidgetItem(
      icon: Padding(
        padding: EdgeInsets.only(left: 2.sw()),
        child: SvgPicture.asset(
          'assets/images/rejected.svg',
          // color: Colors.black,
          width: 12.57.sw(),
          height: 13.62.sh(),
        ),
      ),
      text: 'Rejected'),
  FilterItemWidgetItem(
    icon: Icon(
      Videomanager.refresh,
      color: Colors.black,
      size: 14.88.ssp(),
    ),
    text: 'Reset',
  ),
];

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final FilterItemWidgetItem item;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        item.icon,
        SizedBox(
          width: 9.06.sw(),
        ),
        Text(
          item.text,
          style: kTextStyleIbmRegular.copyWith(
              fontSize: 14.ssp(), color: Colors.black),
        ),
      ],
    );
  }
}

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
