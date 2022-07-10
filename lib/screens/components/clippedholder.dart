import 'package:videomanager/screens/others/exporter.dart';

class ClippedHolder extends StatelessWidget {
  ClippedHolder(
      {Key? key,
      required this.child,
      this.radius = 15,
      this.width = 54,
      this.height = 54,
      this.left,
      this.top = 10,
      this.value = 0})
      : super(key: key);
  final Widget child;
  final double radius, width, height;
  double? left;
  double top;

  final int value;

  final GlobalKey _childKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.sr(),
      height: height.sr(),
      child: value != 0
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                    clipper: ClippedHolderClipper(
                        radius: radius.sr(),
                        left: left ?? width.sr(),
                        top: top),
                    child: SizedBox(key: _childKey, child: child)),
                Positioned(
                  left: left ?? width.sr() - (radius.sr()),
                  top: top - (radius.sr()),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: radius.sr(),
                    child: FittedBox(child: Text(value.toString())),
                  ),
                )
              ],
            )
          : child,
    );
  }

  Size getSize() {
    Future.delayed(const Duration(milliseconds: 10), () {});
    RenderBox box = _childKey.currentContext?.findRenderObject as RenderBox;
    return box.size;
  }
}

class ClippedHolderClipper extends CustomClipper<Path> {
  ClippedHolderClipper(
      {required this.radius, required this.left, required this.top});
  final double radius, left, top;

  @override
  getClip(Size size) {
    // TODO: implement getClip

    Path path = Path();

    path.addOval(Rect.fromCircle(center: Offset(left, top), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
