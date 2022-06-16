import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/settingsbar.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/mapsettings.dart';

final settingIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsHolder extends ConsumerWidget {
  const SettingsHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsindex = ref.watch(settingIndexProvider.state).state;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: SettingsBar(
            settingsIndexState: settingIndexProvider,
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
