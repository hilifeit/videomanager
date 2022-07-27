import 'package:intl/intl.dart';
import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/holder/holder.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotDashboard.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class ScreenshotDashboardHolder extends ConsumerWidget {
  const ScreenshotDashboardHolder({Key? key, required this.thisUser})
      : super(key: key);
  final UserModelMini thisUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileService = ref.watch(fileDetailMiniServiceProvider);
    final userFiles = fileService.userFiles;
    final selectedFile = fileService.selectedUserFile.value;
    if (userFiles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (userFiles.isEmpty) return NoTask();
      if (selectedFile == null)
        return Center(
          child: Text("Select a video to begin"),
        );
      else
        return ScreenshotDashboard(
          thisUser: thisUser,
          videoFile: selectedFile,
        );
    }
  }
}
