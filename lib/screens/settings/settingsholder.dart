import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/mapsettings/mapsettings.dart';
import 'package:videomanager/screens/settings/settingsbar.dart';

final SettingIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsHolder extends ConsumerWidget {
  SettingsHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsindex = ref.watch(SettingIndexProvider.state).state;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: SettingsBar(
            settingsIndexState: SettingIndexProvider,
          )),
          Expanded(
            flex: 5,
            child: AnimatedIndexedStack(index: settingsindex, children: [
              const MapsSettings(),
              Container(
                color: Colors.amber,
              ),
              Container(
                color: Colors.teal,
              ),
              Container(
                color: Colors.blue,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
