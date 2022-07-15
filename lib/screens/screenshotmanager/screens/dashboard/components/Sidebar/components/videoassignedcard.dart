import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class VideoAssignCardItems {
  VideoAssignCardItems(
      {required this.fileName,
      required this.status,
      // required this.filedetail,
      required this.screenShot,
      required this.shops});
  // final FileDetailMini filedetail;
  final String fileName, status;
  final int screenShot;
  final int shops;
}

class VideoAssignCard extends StatelessWidget {
  const VideoAssignCard({
    Key? key,
    required this.thisUser,
    required this.item,
  }) : super(key: key);
  final UserModelMini thisUser;
  final FileDetailMini item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 412.sw(),
      height: 73.sh(),
      child: Card(
        color: const Color(0xffECF0F2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.5.sw()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 88.sw(),
                child: Text(
                  thisUser.superVisor != null ? thisUser.superVisor!.name : '',
                  style: kTextStyleIbmMedium.copyWith(
                      fontSize: 15.ssp(), color: cardHeader),
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
                        color: lightBlack,
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
                              fontSize: 12.ssp(), color: lightBlack),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Videomanager.shop,
                        color: lightBlack,
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
                              fontSize: 12.ssp(), color: lightBlack),
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
    );
  }
}
