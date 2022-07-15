import 'package:videomanager/screens/others/exporter.dart';

final volumeProvider = StateProvider<double>((ref) {
  return 0.5;
});
final mutedProvider = StateProvider<bool>((ref) {
  return false;
});
final timeProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

class CustomVideoPlayer extends StatelessWidget {
  CustomVideoPlayer({Key? key, required this.player, required this.controller})
      : super(key: key);
  final Player player;
  final VideoPlayerController controller;
  bool buffering = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UniversalPlatform.isDesktop
            ? Video(
                player: player,
                showControls: false,
              )
            : VideoPlayer(controller),
        if (buffering)
          Positioned.fill(
              child: Center(
                  child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )))
      ],
    );
  }
}
