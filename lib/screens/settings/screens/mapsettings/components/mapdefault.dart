import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/models/mapsetting_model.dart';
import 'package:videomanager/screens/video/components/videodetails.dart';

class MapDefaultLocation extends ConsumerWidget {
  MapDefaultLocation({Key? key, required this.temp}) : super(key: key);

  final MapSetting temp;
  late final valueProvider = StateProvider<bool>((ref) {
    return temp.defaultLocation.enabled;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(valueProvider.state).state;
    return Column(
      children: [
        CustomSwitch(
          text: 'Map Default Location',
          space: 0.sw(),
          value: enabled,
          onChanged: (val) {
            ref.read(valueProvider.state).state = val;
            temp.defaultLocation.enabled = val;
          },
        ),
        if (enabled) ...[
          SizedBox(
            height: 22.sh(),
          ),
          Container(
            width: 816.sw(),
            height: 49.sh(),
            decoration: BoxDecoration(
                color: lightWhite.withOpacity(0.22),
                borderRadius: BorderRadius.circular(4.sr())),
            child: Padding(
              padding: EdgeInsets.only(
                left: 32.sw(),
                top: 14.sh(),
                bottom: 14.sh(),
              ),
              child: Row(
                children: [
                  VideoDetailText(
                    title: 'Latitude',
                    details: temp.defaultLocation.lat.toString(),
                  ),
                  SizedBox(width: 11.sw()),
                  VideoDetailText(
                    title: 'Longitutde',
                    details: temp.defaultLocation.lng.toString(),
                  ),
                ],
              ),
            ),
          ),
        ]
      ],
    );
  }
}
