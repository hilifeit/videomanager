import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

final videoServiceProvider = ChangeNotifierProvider<VideoService>((ref) {
  return VideoService();
});

class VideoService extends ChangeNotifier {


  
}
