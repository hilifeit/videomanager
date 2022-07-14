import 'package:videomanager/screens/components/compoenttest.dart';
import 'package:videomanager/screens/holder/components/menubar.dart';
import 'package:videomanager/screens/others/exporter.dart';

import 'package:videomanager/screens/screenshotmanager/screens/playvideo.dart';
import 'package:videomanager/screens/settings/settingsholder.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/users.dart';
import 'package:videomanager/screens/viewscreen/models/filedetail.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

import 'package:videomanager/screens/viewscreen/viewscreen.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class Holder extends ConsumerWidget {
  Holder({Key? key}) : super(key: key);

  final fileDetailProvider = FutureProvider<FileDetail?>((ref) async {
    FileDetail? fileDetail;
    final file = ref.watch(fileDetailMiniServiceProvider);
    if (file.files.isNotEmpty) {
      fileDetail = await file.fetchOne(file.files.first.id);
      fileDetail.foundPath = await file.getUrlFromFile(file.files.first);
      print(fileDetail.foundPath);
    }
    return fileDetail;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomKeys().init(ref, context);
    final index = ref.watch(indexProvider.state).state;
    ref.read(userChangeProvider).fetchAll();
    final thisUser = ref.read(userChangeProvider).loggedInUser.value;
    final fileDetail = ref.watch(fileDetailProvider);
    final futureBuilder = fileDetail.when(data: (data) {
      return data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PlayVideo(videoFile: data, role: thisUser!.role);
    }, error: (e, s) {
      return Container(
        child: Center(child: Text("$e $s")),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          MenuBar(
            indexState: indexProvider,
          ),
          (thisUser!.role > 0)
              ? Expanded(
                  child: index != 4
                      ? AnimatedIndexedStack(index: index, children: [
                          ViewScreen(),
                          const Users(),
                          AddRemarksOnSubmit(),
                          futureBuilder,
                        ])
                      : const SettingsHolder(),
                )
              : Expanded(
                  child: index != 1
                      ? AnimatedIndexedStack(index: index, children: [
                          futureBuilder,
                        ])
                      : const SettingsHolder(),
                ),
        ],
      ),
    );
  }
}
