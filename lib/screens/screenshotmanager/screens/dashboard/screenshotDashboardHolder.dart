import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/holder/holder.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/videosidebar.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/screenshotDashboard.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

final showVideoBarProvider = StateProvider<bool>((ref) {
  return false;
});

class ScreenshotDashboardHolder extends StatelessWidget {
  const ScreenshotDashboardHolder({Key? key, required this.thisUser})
      : super(key: key);
  final UserModelMini thisUser;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (thisUser.role == Roles.user.index) selector(),
        Consumer(builder: (context, ref, c) {
          final showVideoBar = ref.watch(showVideoBarProvider.state).state;
          if (!ResponsiveLayout.isMobile) {
            if (!showVideoBar) {
              return Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    ref.read(showVideoBarProvider.state).state = true;
                  },
                  child: Container(
                    width: 30.sw(),
                    height: 155.sh(),
                    color: const Color(0xffE4F5FF),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            } else {
              return Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 560.sw(), child: VideoSideBar(thisUser: thisUser)),
              );
            }
          } else {
            return VideoSideBar(thisUser: thisUser);
          }
        }),
      ],
    );
  }

  Widget selector() {
    return Consumer(builder: (context, ref, c) {
      final fileService = ref.watch(fileDetailMiniServiceProvider);
      final userFiles = fileService.userFiles;
      final selectedFile = fileService.selectedUserFile.value;
      if (userFiles == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (userFiles.isEmpty) return NoTask();
        if (selectedFile == null) {
          return const Center(
            child: Text("Select a video to begin"),
          );
        } else {
          return ScreenshotDashboard(
            thisUser: thisUser,
            videoFile: selectedFile,
          );
        }
      }
    });
  }
}
