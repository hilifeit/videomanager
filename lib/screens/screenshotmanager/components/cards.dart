import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77.sh(),
      width: 268.sw(),
      child: Card(
        color: const Color(0xffE4F5FF),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 26.sw(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Videomanager.shop_2,
                    color: primaryColor,
                    size: 14.ssp(),
                  ),
                  SizedBox(
                    width: 15.sw(),
                  ),
                  Text(
                    shop.shopName,
                    style: kTextStyleInterMedium.copyWith(
                      fontSize: 15.ssp(),
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 13.sh(),
              ),
              Row(
                children: [
                  Text(
                    shop.category,
                    style: kTextStyleInterMedium.copyWith(
                        fontSize: 12.ssp(), color: lightBlack),
                  ),
                  const Spacer(),
                  Text(
                    shop.shopSize,
                    style: kTextStyleInterMedium.copyWith(
                        fontSize: 12.ssp(), color: lightBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
              SizedBox(
                width: 10.sw(),
              ),
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
                        width: 60.sw(),
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
                        width: 60.sw(),
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
              StatusCard(status: item.status.status.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class Status {
  Status({required this.status, required this.color});
  final String status;
  final Color color;
}

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;
  late Color color;
  @override
  Widget build(BuildContext context) {
    List<Status> items = [
      Status(status: 'Pending', color: danger),
      Status(status: 'Complete', color: sucess),
      Status(status: 'Ongoing', color: primaryColor),
      Status(status: 'Approved', color: sucess),
      Status(status: 'Rejected', color: danger)
    ];

    for (var element in items) {
      if (element.status == status) {
        color = element.color;
        break;
      }
    }

    return Container(
      width: 95.sw(),
      height: 22.sh(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sr()),
        color: color.withOpacity(0.16),
      ),
      child: Center(
        child: Text(
          status,
          style: kTextStyleIbmMedium.copyWith(fontSize: 13.ssp(), color: color),
        ),
      ),
    );
  }
}
