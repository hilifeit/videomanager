import 'package:videomanager/screens/components/helper/customoverlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class VideoAssignCard extends ConsumerWidget {
  VideoAssignCard({
    Key? key,
    required this.thisUser,
    required this.item,
  }) : super(key: key);
  final UserModelMini thisUser;
  final FileDetailMini item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileService = ref.watch(fileDetailMiniServiceProvider);
    final selected = fileService.selectedUserFile.value?.id;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (thisUser.role == 1)
          Consumer(builder: (context, ref, c) {
            return Checkbox(
              value: item.isSelected,
              onChanged: (val) {
                fileService.selectOrDeselectFile([item], val!);
              },
            );
          }),
        Expanded(
          // width: 412.sw(),
          // height: 73.sh(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(fileDetailMiniServiceProvider)
                    .selectUserVideoFile(item.id);
              },
              child: Card(
                color: selected == item.id ? Color(0xffECF0F2) : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.5.sw(), vertical: 16.sh()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.sw(),
                        child: Column(
                          children: [
                            if (thisUser.role == 0)
                              Text(
                                thisUser.superVisor != null
                                    ? thisUser.superVisor!.name
                                    : '',
                                style: kTextStyleIbmMedium.copyWith(
                                    fontSize: 15.ssp(),
                                    color: selected == item.id
                                        ? blackColor
                                        : notExactlyPrimary),
                              ),
                            if (thisUser.role == Roles.manager.index) ...[
                              Text(
                                // TODO: video assigned to whom? "username"
                                (item.assignDetail!.assignedTo == null)
                                    ? 'Not Assigned'
                                    : item.assignDetail!.assignedTo!,
                                style: kTextStyleIbmMedium.copyWith(
                                    fontSize: 15.ssp(),
                                    color: notExactlyPrimary),
                              ),

                              // TODO: if video Assigned available show user's "name"

                              if (item.assignDetail!.assignedTo != null)
                                Text(
                                  'Name',
                                  style: kTextStyleIbmMedium.copyWith(
                                    fontSize: 15.ssp(),
                                  ),
                                ),
                            ]
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 70.sw(),
                        child: Text(
                          item.filename,
                          style: kTextStyleIbmMedium.copyWith(
                              fontSize: 12.ssp(), color: Colors.black),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10.sw(),
                      // ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Videomanager.image_icon_group,
                                color: selected == item.id
                                    ? blackColor
                                    : lightBlack,
                                size: 9.5.ssp(),
                              ),
                              SizedBox(
                                width: 5.sw(),
                              ),
                              SizedBox(
                                // width: 30.sw(),
                                child: Text(
                                  10.toString(),
                                  style: kTextStyleIbmMedium.copyWith(
                                      fontSize: 12.ssp(),
                                      color: selected == item.id
                                          ? blackColor
                                          : lightBlack),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Videomanager.shop,
                                color: selected == item.id
                                    ? blackColor
                                    : lightBlack,
                                size: 10.48.ssp(),
                              ),
                              SizedBox(
                                width: 5.sw(),
                              ),
                              SizedBox(
                                // width: 30.sw(),
                                child: Text(
                                  10.toString(),
                                  style: kTextStyleIbmMedium.copyWith(
                                      fontSize: 12.ssp(),
                                      color: selected == item.id
                                          ? blackColor
                                          : lightBlack),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      StatusCard(status: item.status.status.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
