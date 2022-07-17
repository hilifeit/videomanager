import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';

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
                    shop.shopName!,
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
                    shop.category!,
                    style: kTextStyleInterMedium.copyWith(
                        fontSize: 12.ssp(), color: lightBlack),
                  ),
                  const Spacer(),
                  Text(
                    shop.shopSize.toString(),
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



// List<Status> itemStatus = [
//   Status(status: 'Pending', color: danger),
//   Status(status: 'Ongoing', color: primaryColor),
//   Status(status: 'Rejected', color: danger),
//   Status(status: 'Complete', color: sucess),
//   Status(status: 'Approved', color: sucess),
// ];

