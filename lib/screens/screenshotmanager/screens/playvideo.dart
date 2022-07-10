import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

List<VideoAssignCardItems> items = [
  VideoAssignCardItems(
      fileName: "rapaddddddddddddddddddddddddti",
      screenShot: 451,
      shops: 2150,
      status: 'Pending'),
  VideoAssignCardItems(
      fileName: "bagmati", screenShot: 155, shops: 52, status: 'Approved'),
  VideoAssignCardItems(
      fileName: "gandaki", screenShot: 144, shops: 5555, status: 'Complete'),
  VideoAssignCardItems(
      fileName: "daada", screenShot: 451, shops: 55, status: 'Rejected'),
  VideoAssignCardItems(
      fileName: "rapaddti", screenShot: 451, shops: 211, status: 'Ongoing'),
];

class _PlayVideoState extends State<PlayVideo> {
  bool showOverlay = false;

  late OverlayEntry overlayEntry;
  final GlobalKey keey = GlobalKey();
  _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 73.sh(),
          height: size.height - 73.sh(),
          width: 412.sw(),

          //  top: renderBox.globalToLocal(point),
          child: Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // color: Colors.amber,
                  height: 447.sh(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Videos',
                              style: kTextStyleIbmMedium.copyWith(
                                fontSize: 18.ssp(),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.sr()),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4.sr())),
                              child: Icon(Videomanager.filter,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13.sh(),
                      ),
                      Expanded(
                        child: Consumer(builder: (context, ref, c) {
                          final thisUser =
                              ref.watch(userChangeProvider).loggedInUser.value;
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
                  ),
                ),
              ],
            ),
          ));
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     keey;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Expanded(
            flex: 14,
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            height: 73.sh(),
            color: primaryColor,
            child: Row(
              children: [
                SizedBox(
                  width: 51.sw(),
                ),
                Icon(
                  Videomanager.rewind,
                  color: Colors.white,
                  size: 21.75.ssp(),
                ),
                SizedBox(
                  width: 33.sw(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 24.ssp(),
                  ),
                ),
                SizedBox(
                  width: 30.5.sw(),
                ),
                Icon(
                  Videomanager.volume,
                  color: Colors.white,
                  size: 24.ssp(),
                ),
                SizedBox(
                  width: 6.75.sw(),
                ),
                CustomSliderHollowThumb(value: 0.5, onChanged: (val) {}),
                SizedBox(
                  width: 24.sw(),
                ),
                Text(
                  '5:00 / 10:00',
                  style: kTextStyleInterMedium.copyWith(
                      fontSize: 14.ssp(),
                      color: const Color(0xffeaeaea).withAlpha(180)),
                ),
                const Spacer(),
                Text(
                  'FileName',
                  style: kTextStyleInterMedium.copyWith(
                    fontSize: 24.ssp(),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 43.sw(),
                ),
                Container(
                  width: 50.sr(),
                  height: 50.sr(),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Videomanager.camera,
                    color: Theme.of(context).primaryColor,
                    size: 24.ssp(),
                  ),
                ),
                SizedBox(
                  width: 32.sw(),
                ),
                CustomElevatedButton(
                  width: 120.sw(),
                  height: 49.sw(),
                  color: Colors.white,
                  onPressedElevated: () {
                    OverlayState overlayState = Overlay.of(context)!;
                    if (!showOverlay) {
                      overlayEntry = _createOverlay();
                      overlayState.insert(overlayEntry);
                    } else {
                      overlayEntry.remove();
                    }
                    setState(() {
                      showOverlay = !showOverlay;
                    });
                  },
                  elevatedButtonText: "Submit",
                  elevatedButtonTextStyle: kTextStyleInterMedium.copyWith(
                    fontSize: 20.ssp(),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 47.sw(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
