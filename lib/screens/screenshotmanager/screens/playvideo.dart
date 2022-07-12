import 'package:videomanager/screens/components/assignuser/assignuser.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/video/components/videoplayercontrols.dart';

enum Filter { Pending, Complete, Ongoing, Approved, Rejected }

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

final List<CustomMenuItem> menus = [
  CustomMenuItem(label: "User", value: 0.toString()),
  CustomMenuItem(label: "Manager", value: 1.toString()),
];

class _PlayVideoState extends State<PlayVideo> {
  bool showOverlay = false;

  late OverlayEntry overlayEntry;
  final GlobalKey keey = GlobalKey();

  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Expanded(
            flex: 14,
            child: LayoutBuilder(builder: (context, c) {
              return Stack(
                children: [
                  Expanded(
                    flex: 14,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        OverlayState overlayState = Overlay.of(context)!;
                        if (!showOverlay) {
                          overlayEntry = overlay.createOverlay(context);
                          overlayState.insert(overlayEntry);
                        }
                        setState(() {
                          showOverlay = !showOverlay;
                        });
                      },
                      child: Container(
                          width: 30.sw(),
                          height: 155.sh(),
                          color: Color(0xffE4F5FF),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  if (showOverlay)
                    Positioned(
                      right: 503.sw(),
                      bottom: c.maxHeight / 2 - (155.sh() / 2),
                      child: InkWell(
                        onTap: () {
                          overlayEntry.remove();

                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        },
                        child: Container(
                            width: 30.sw(),
                            height: 155.sh(),
                            color: Color(0xffE4F5FF),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.black,
                            )),
                      ),
                    )
                ],
              );
            }),
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
                    fontSize: 18.ssp(),
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
                  padding: EdgeInsets.only(right: 3.sw(), bottom: 3.sh()),
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
                  height: 40.sw(),
                  color: Colors.white,
                  onPressedElevated: () {},
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
