import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/video/components/models/playerController.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class StartEndTime {
  late Duration leftStart, leftEnd, rightStart, rightEnd;
}

final dualVideoServiceProvider =
    ChangeNotifierProvider<DualVideoService>((ref) {
  return DualVideoService._();
});

class DualVideoService extends ChangeNotifier {
  DualVideoService._();
  late final desktop1 = Property<PlayerController?>(null, notifyListeners);
  late final desktop2 = Property<PlayerController?>(null, notifyListeners);
  late final web1 = Property<VideoPlayerController?>(null, notifyListeners);
  late final web2 = Property<VideoPlayerController?>(null, notifyListeners);

  StartEndTime calculateStartTime(FileDetail left, FileDetail right) {
    StartEndTime data = StartEndTime();
    var leftEndinDuration = getTimeinDuration(left.info.modifiedDate);
    var rightEndinDuration = getTimeinDuration(right.info.modifiedDate);

    var leftStartinDuration = getTimeinDuration(
        left.info.modifiedDate.subtract(getTimeinDuration(left.info.duration)));
    var rightStartinDuration = getTimeinDuration(right.info.modifiedDate
        .subtract(getTimeinDuration(right.info.duration)));

    Duration? leftEndLocinDuration,
        rightEndLocinDuration,
        leftStartLocinDuration,
        rightStartLocinDuration;

    if (left.info.endTimeLoc != null &&
        right.info.endTimeLoc != null &&
        left.info.startTimeLoc != null &&
        right.info.startTimeLoc != null) {
      leftEndLocinDuration = getTimeinDuration(left.info.endTimeLoc!);
      rightEndLocinDuration = getTimeinDuration(right.info.endTimeLoc!);
      leftStartLocinDuration = getTimeinDuration(left.info.startTimeLoc!);
      rightStartLocinDuration = getTimeinDuration(right.info.startTimeLoc!);

      Duration videoEndTime, locationEndTime;
      videoEndTime = leftEndinDuration - rightEndinDuration;
      locationEndTime = leftEndLocinDuration - rightEndinDuration;

      // print(videoEndTime.inMilliseconds);
      // print(locationEndTime.inMilliseconds);

      if (videoEndTime.inMilliseconds > locationEndTime.inMilliseconds) {
        leftStartinDuration = leftStartLocinDuration;
        leftEndinDuration = leftEndLocinDuration;
        rightStartinDuration = rightStartLocinDuration;
        rightEndinDuration = rightEndLocinDuration;
      }
    }

    if (leftStartinDuration > rightStartinDuration) {
      data.leftStart = Duration.zero;
      data.rightStart = leftStartinDuration - rightStartinDuration;
    } else if (leftStartinDuration == rightStartinDuration) {
      data.leftStart = Duration.zero;
      data.rightStart = Duration.zero;
    } else {
      data.leftStart = rightStartinDuration - leftStartinDuration;
      data.rightStart = Duration.zero;
    }

    if (leftEndinDuration < rightEndinDuration) {
      data.leftEnd = Duration.zero;
      data.rightEnd = leftEndinDuration - rightEndinDuration;
    } else if (leftEndinDuration == rightEndinDuration) {
      data.leftEnd = Duration.zero;
      data.rightEnd = Duration.zero;
    } else {
      data.leftEnd = rightEndinDuration - leftEndinDuration;
      data.rightEnd = Duration.zero;
    }
    // print(data.leftStart.toString() +
    //     data.leftEnd.toString() +
    //     data.rightStart.toString() +
    //     data.rightEnd.toString());
    return data;
  }

  Duration getTimeinDuration(DateTime date) {
    return Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
        milliseconds: date.millisecond);
  }

  dispose() {
    if (UniversalPlatform.isDesktop) {
      if (desktop1.value!.player.playback.isPlaying) {
        desktop1.value!.player.pause();
      }
      if (desktop2.value!.player.playback.isPlaying) {
        desktop2.value!.player.pause();
      }
      desktop1.value!.player.dispose();
      desktop2.value!.player.dispose();
    } else {
      web1.value!.dispose();
      web2.value!.dispose();
    }
  }
}
