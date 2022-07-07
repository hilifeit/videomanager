import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/users/model/usermodelmini.dart';

class ShopCard extends StatelessWidget {
  ShopCard({Key? key, required this.shop}) : super(key: key);
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

class VideoAssignCard extends StatelessWidget {
  VideoAssignCard({Key? key, required this.thisUser}) : super(key: key);
  final UserModelMini thisUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 412.sw(),
      height: 73.sh(),
      child: Card(
        color: Color(0xffECF0F2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.5.sw()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                thisUser.superVisor!.name,
                style: kTextStyleIbmMedium.copyWith(
                    fontSize: 15.ssp(), color: cardHeader),
              ),
              Spacer(),
              Text(
                'videoFile',
                style: kTextStyleIbmMedium.copyWith(
                    fontSize: 12.ssp(), color: Colors.black),
              ),
              Spacer(),
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
                      Text(
                        '60',
                        style: kTextStyleIbmMedium.copyWith(
                            fontSize: 12.ssp(), color: lightBlack),
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
                      Text(
                        '60',
                        style: kTextStyleIbmMedium.copyWith(
                            fontSize: 12.ssp(), color: lightBlack),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              StatusCard(color: dangerSecondary, status: 'Pending')
            ],
          ),
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
    required this.color,
    required this.status,
  }) : super(key: key);

  final Color color;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.sw(),
      height: 22.sh(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sr()),
        color: color,
      ),
      child: Center(
        child: Text(
          status,
          style:
              kTextStyleIbmMedium.copyWith(fontSize: 13.ssp(), color: danger),
        ),
      ),
    );
  }
}
