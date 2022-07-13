import 'package:videomanager/screens/components/helper/overlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/sliderwithtext.dart';

final volumeProvider = StateProvider<double>((ref) {
  return 0.5;
});
final mutedProvider = StateProvider<bool>((ref) {
  return false;
});

class PlayVideo extends ConsumerWidget {
  PlayVideo({Key? key}) : super(key: key);

  final List<CustomMenuItem> menus = [
    CustomMenuItem(label: "User", value: 0.toString()),
    CustomMenuItem(label: "Manager", value: 1.toString()),
  ];

  // bool showOverlay = false;

  late OverlayEntry overlayEntry;
  // final GlobalKey keey = GlobalKey();

  // late GlobalKey _key;
  // bool isMenuOpen = false;
  // late Offset buttonPosition;
  // late OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double volume = ref.watch(volumeProvider.state).state;
    final bool mute = ref.watch(mutedProvider.state).state;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Expanded(
            flex: 14,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.blue[100],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      OverlayState overlayState = Overlay.of(context)!;
                      CustomOverlayEntry().createOverlay(context);
                      overlayEntry = CustomOverlayEntry().overlay;
                      overlayState.insert(overlayEntry);
                    },
                    child: Container(
                        width: 30.sw(),
                        height: 155.sh(),
                        color: const Color(0xffE4F5FF),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black,
                        )),
                  ),
                ),
                // if (showOverlay)
                //   Positioned(
                //     right: 503.sw(),
                //     bottom: c.maxHeight / 2 - (155.sh() / 2),
                //     child: InkWell(
                //       onTap: () {
                //         overlayEntry.remove();

                //         setState(() {
                //           showOverlay = !showOverlay;
                //         });
                //       },
                //       child: Container(
                //           width: 30.sw(),
                //           height: 155.sh(),
                //           color: Color(0xffE4F5FF),
                //           child: Icon(
                //             Icons.chevron_right_rounded,
                //             color: Colors.black,
                //           )),
                //     ),
                //   )
              ],
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
                IconButton(
                  onPressed: () {
                    ref.read(mutedProvider.state).state = !mute;
                  },
                  icon: mute || volume == 0
                      ? Icon(
                          Icons.volume_off,
                          color: Colors.white,
                          size: 24.ssp(),
                        )
                      : Icon(
                          Videomanager.volume,
                          color: Colors.white,
                          size: 24.ssp(),
                        ),
                ),
                SizedBox(
                  width: 6.75.sw(),
                ),
                CustomSliderHollowThumb(
                    value: mute ? 0 : volume,
                    onChanged: (val) {
                      ref.read(volumeProvider.state).state = val;
                    }),
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
