import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/components/snackbar/customsnackbar.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

export 'dart:convert';

export 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.js) "package:videomanager/screens/video/components/fakeDartVlc.dart";
export 'package:file_picker/file_picker.dart';
export 'package:flutter/material.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:get_storage/get_storage.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:latlng/latlng.dart';
export 'package:universal_platform/universal_platform.dart';
export 'package:video_player/video_player.dart';
export 'package:videomanager/screens/components/animatedindexedstack.dart';
export 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
export 'package:videomanager/screens/components/helper/extension.dart';
export 'package:videomanager/screens/components/helper/keys.dart';
export 'package:videomanager/screens/components/responsivelayout.dart';
export 'package:videomanager/screens/components/socket.dart';
// own components
export 'package:videomanager/screens/others/constant.dart';
export 'package:videomanager/screens/others/ip.dart';
export 'package:videomanager/screens/others/theme.dart';
export 'package:videomanager/screens/others/validator.dart';
export 'package:videomanager/screens/others/widgets.dart';
export 'package:videomanager/screens/others/enums.dart';
export 'package:videomanager/videomanager_icons.dart';
export 'package:videomanager/screens/components/audioPlayer.dart';
//

final client = http.Client();

final LatLng home = LatLng(26.4721557, 87.32396419999999);

final storage = GetStorage();

final snackVisibleProvider = StateProvider<bool>((ref) {
  return false;
});
String getVideoUrl(String id, {VideoQuality quality = VideoQuality.q480p}) =>
    "${CustomIP.apiBaseUrl}video/$id?q=${quality.name.replaceAll("q", "").replaceAll("p", "")}";
final CustomSnackBar snack = CustomSnackBar();
// final CustomShowMessage message = CustomShowMessage();

logout() {
  try {
    customSocket.socket.disconnect();
  } catch (e, s) {
    print("$e $s");
  }

  if (CustomOverlayEntry().videoTimeStampOpen) {
    CustomOverlayEntry().closeVideoTimeStamp();
  }
  storage.remove(userStorageKey);
  if (CustomOverlayEntry().videoTimeStampOpen) {
    CustomOverlayEntry().closeVideoTimeStamp();
  }
  Phoenix.rebirth(CustomKeys().context!);
}
