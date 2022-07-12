import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class CustomOverlayEntry {
  static final CustomOverlayEntry _instance = CustomOverlayEntry._internal();

  factory CustomOverlayEntry() => _instance;

  CustomOverlayEntry._internal();

  createOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 73.sh(),
          height: size.height,
          width: 503.sw(),

          //  top: renderBox.globalToLocal(point),
          child: Material(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 37.sw(), right: 54.sw(), bottom: 0.sh()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 480.sh(),
                    child: Consumer(builder: (context, ref, c) {
                      final filterSelect =
                          ref.watch(filterItemProvider.state).state;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Videos',
                                style: kTextStyleIbmMedium.copyWith(
                                  fontSize: 18.ssp(),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (filterSelect != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.sw(),
                                      ),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child:
                                          FilterItemWidget(item: filterSelect)),
                                ),
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
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return VideoAssignCard(
                                      item: items[index],
                                      thisUser: thisUser!,
                                    );
                                  },
                                  separatorBuilder: (context, _) {
                                    return SizedBox(
                                      height: 8.sh(),
                                    );
                                  },
                                  itemCount: items.length);
                            }),
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

final filterItemProvider = StateProvider<FilterItemWidgetItem?>((ref) {
  return null;
});

class FilterIconButton extends ConsumerStatefulWidget {
  FilterIconButton({
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

  void closeMenu() {
    overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu(BuildContext context) {
    overlayEntry = _overlayEntryBuilder(context);
    Overlay.of(context)!.insert(overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  // @override
  // void initState() {
  //   super.initState();

  //   foucusNode.addListener(() {
  //     if (!foucusNode.hasFocus) {
  //       closeMenu();
  //     }
  //   });
  // }

  OverlayEntry _overlayEntryBuilder(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
    var size = renderBox.size;
    return OverlayEntry(
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    filterItems.length,
                    (index) => filterItems[index] != filterItems.last
                        ? InkWell(
                            onTap: () {
                              ref.read(filterItemProvider.state).state =
                                  filterItems[index];
                              closeMenu();
                            },
                            child: FilterItemWidget(
                              item: filterItems[index],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              ref.read(filterItemProvider.state).state = null;
                              closeMenu();
                            },
                            child: FilterItemWidget(
                              item: filterItems[index],
                            ),
                          ),
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(7.sr()),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(4.sr())),
      child: Row(
        children: [
          IconButton(
            focusNode: foucusNode,
            icon: Icon(Videomanager.filter, color: Colors.white),
            onPressed: () {
              if (isMenuOpen) {
                closeMenu();
              } else {
                openMenu(context);
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
  FilterItemWidget({
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
