import 'package:videomanager/screens/others/exporter.dart';

class TypingWidget extends StatelessWidget {
  TypingWidget({Key? key, this.scaleFactor = 0.5}) : super(key: key);
  final double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: scaleFactor,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(width: 200, height: 200),
            Positioned(
              left: -95 * (1 / scaleFactor),
              top: 80 * (1 / scaleFactor),
              child: Image.asset(
                'assets/animation/typing_animation.gif',
              ),
            ),
          ],
        ));
  }
}
