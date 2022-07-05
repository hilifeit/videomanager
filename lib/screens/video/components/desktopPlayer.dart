// import 'package:dart_vlc/dart_vlc.dart' if (dart.library.js) "fakeVideo.dart"
//     as vlc;
// import 'package:flutter/foundation.dart';
// import 'package:videomanager/screens/others/exporter.dart';
// import 'package:videomanager/screens/video/video.dart';

// abstract class VideoPlayerSelecter {
//   Widget get videoPlayer;

//   factory VideoPlayerSelecter() {
//     if (kIsWeb) {
//       return _WebImplementation();
//     }
//     return _DesktopImplementation();
//   }
// }

// class _WebImplementation implements VideoPlayerSelecter {
//   @override
//   Widget get videoPlayer => Consumer(builder: (context, ref, c) {
//         return const CustomVideo(
//           pathLeft: '',
//           pathRight: '',
//         );
//       });
// }

// class _DesktopImplementation implements VideoPlayerSelecter {
//   @override
//   Widget get videoPlayer => vlc.Video();
// }
