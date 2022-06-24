// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:videomanager/screens/others/exporter.dart';

// class Magnifier extends ConsumerWidget {
//   Magnifier({Key? key, required this.child, this.enabled = true})
//       : super(key: key);
//   final Widget child;
//   final bool enabled;
//   final postionProvider = StateProvider<Offset>((ref) {
//     return const Offset(0, 0);
//   });
//   @override
//   Widget build(BuildContext context, ref) {
//     return LayoutBuilder(builder: (context, constraint) {
//       // print(
//       //     '${constraint.maxWidth} ${constraint.maxHeight} | ${constraint.maxWidth * 1.5} ${constraint.maxHeight * 1.5}');
//       return Listener(
//         onPointerHover: (detail) {
//           ref.read(postionProvider.state).state =
//               Offset(detail.localPosition.dx, detail.localPosition.dy);
//           print(detail.localPosition);
//         },
//         child: Stack(
//           children: [
//             child,
//             if (enabled)
//               ClipPath(
//                 clipper: CustomMagnifierClipper(
//                     offsetProvider: postionProvider, ref: ref),
//                 child: Container(color: Colors.grey, child: child),
//               )
//           ],
//         ),
//       );
//     });
//   }
// }

// class CustomMagnifierClipper extends CustomClipper<Path> {
//   CustomMagnifierClipper({required this.offsetProvider, required this.ref});
//   final StateProvider<Offset> offsetProvider;
//   final WidgetRef ref;
//   @override
//   getClip(Size size) {
//     // TODO: implement getClip

//     final postion = ref.watch(offsetProvider.state).state;
//     Path path = Path();
//     path.addRRect(RRect.fromRectXY(
//         Rect.fromLTWH(postion.dx, postion.dy, 50, 50), 25, 25));
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     // TODO: implement shouldReclip
//     return true;
//   }
// }
