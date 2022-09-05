import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';

class SnapModel {
  SnapModel({required this.shops, required this.timeStamp, this.image});
  final List<Shop> shops;
  Duration timeStamp;
  Uint8List? image;
  static int get width {
    double width = 25.sw();
    return width.toInt();
  }

  static int get height {
    double height = 21.sh();
    return height.toInt();
  }

  ui.Image? decodedImage;

  // decodeImage(Uint8List img) async {
  //   try {
  //     final codec = await ui.instantiateImageCodec(img,
  //         targetHeight: height, targetWidth: width);

  //     final frame = await codec.getNextFrame();
  //     decodedImage = frame.image;
  //     // decodedImage = await decodeImageFromList(img);
  //     image = img;
  //   } catch (e, s) {
  //     print('$e $s');
  //   }
  // }
}
