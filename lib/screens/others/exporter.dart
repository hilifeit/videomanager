import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:latlng/latlng.dart';
export 'package:video_player/video_player.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:map/map.dart';
export 'package:searchfield/searchfield.dart';
export 'package:file_picker/file_picker.dart';

// own components
export 'package:videomanager/screens/others/constant.dart';
export 'package:videomanager/videomanager_icons.dart';
export 'package:videomanager/screens/others/theme.dart';
export 'package:videomanager/screens/others/validator.dart';
export 'package:videomanager/screens/others/widgets.dart';
export 'package:videomanager/screens/components/animatedindexedstack.dart';
//

const baseURL = "http://192.168.1.10:5000/api/";
final client = http.Client();

final LatLng home = LatLng(27.7251933, 85.3411312);