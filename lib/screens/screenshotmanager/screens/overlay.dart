import 'package:videomanager/screens/others/exporter.dart';

class OverlayTest extends StatefulWidget {
  const OverlayTest({Key? key}) : super(key: key);

  @override
  State<OverlayTest> createState() => _OverlayTestState();
}

class _OverlayTestState extends State<OverlayTest> {
  final FocusNode foucusNode = FocusNode();
  late OverlayEntry overlayEntry;
  final GlobalKey globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Positioned(
          width: size.width,
          //  top: renderBox.globalToLocal(point),
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(0, size.height),
            child: Material(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Your search did not match any documents.',
                        textAlign: TextAlign.center, maxLines: 2),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OverlayState overlayState = Overlay.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalKey;
    });
    foucusNode.addListener(() {
      if (foucusNode.hasFocus) {
        overlayEntry = _createOverlay();
        overlayState.insert(overlayEntry);
      } else {
        overlayEntry.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        style: kTextStyleInterMedium.copyWith(fontSize: 16.ssp()),
        textAlignVertical: TextAlignVertical.center,
        focusNode: foucusNode,
        decoration: InputDecoration(
          prefixIcon:
              Icon(Videomanager.search, color: Colors.black, size: 14.ssp()),
          fillColor: secondaryColor,
          filled: true,
          contentPadding:
              EdgeInsets.only(left: 10.5.sw(), top: 9.sh(), bottom: 11.sh()),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sr()),
            borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sr()),
            borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
          ),
          hintText: 'Search',
          hintStyle: kTextStyleInterMedium,
        ),
      ),
    );
  }
}
