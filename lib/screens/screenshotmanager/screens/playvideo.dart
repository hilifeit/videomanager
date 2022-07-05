import 'package:videomanager/screens/others/exporter.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  bool showOverlay = false;

  late OverlayEntry overlayEntry;
  final GlobalKey keey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Positioned(
          right: 0,
          bottom: 0,
          height: size.height,

          //  top: renderBox.globalToLocal(point),
          child: Material(
            child: TestWidget(),
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      keey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 1471.sw(),
        height: 1000.sh(),
        color: Colors.amber,
        child: Column(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('object');
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
                child: Container(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
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
