import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/filter.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({Key? key}) : super(key: key);
  final controller = MapController(
    location: home,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Filter(
                mapController: controller,
              ),
            ),
            Expanded(
              flex: 5,
              child: MapScreen(
                draw: true,
                controller: controller,
                isvisible: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
