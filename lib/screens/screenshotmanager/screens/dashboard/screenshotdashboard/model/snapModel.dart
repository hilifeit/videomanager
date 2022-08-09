import 'dart:typed_data';

import 'package:videomanager/screens/screenshotmanager/models/shops.dart';

class SnapModel {
  SnapModel({required this.shops, required this.timeStamp, this.image});
  final List<Shop> shops;
  Duration timeStamp;
  Uint8List? image;
}
