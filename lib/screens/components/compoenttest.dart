import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class AddRemarksOnSubmit extends ConsumerWidget {
  AddRemarksOnSubmit({
    Key? key,
  }) : super(key: key);
  Duration? duration;
  double? progress;
  int? sxshot, outlet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 493.sh(),
      width: 525.sw(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sr()),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left: 35.sw(), right: 38.sw()),
          height: 42.sh(),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sr()),
                topRight: Radius.circular(8.sr())),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Remarks',
                style: kTextStyleIbmRegular.copyWith(
                  fontSize: 16.ssp(),
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.ssp(),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 38.sw(), vertical: 25.sh()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 70.sw(),
                  runSpacing: 29.sh(),
                  children: [
                    WidgetRemarks(
                      icon: Videomanager.videooutline,
                      title: 'Video Length',
                      item: "10:00:05",
                    ),
                    WidgetRemarks(
                      icon: Videomanager.videooutline,
                      title: 'Progress',
                      item: '90%',
                    ),
                    WidgetRemarks(
                      icon: Videomanager.image_icon,
                      title: 'No. of Screenshot',
                      item: "10",
                    ),
                    SizedBox(
                      width: 97.sw(),
                      child: WidgetRemarks(
                        icon: Videomanager.shop,
                        title: 'Outlet',
                        item: "200",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sh(),
                ),
                InputTextField(
                    title: 'Remarks', isVisible: true, onChanged: (val) {}),
                SizedBox(
                  height: 25.sh(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElevatedButton(
                      width: 120.sw(),
                      height: 49.sh(),
                      onPressedElevated: () {},
                      elevatedButtonText: 'Submit'),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class WidgetRemarks extends StatelessWidget {
  WidgetRemarks({
    Key? key,
    required this.icon,
    required this.title,
    required this.item,
  }) : super(key: key);
  final IconData icon;
  final String title, item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76.sh(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 20.ssp(),
            color: primaryColor,
          ),
          Text(
            title,
            style: kTextStyleIbmSemiBold.copyWith(
              fontSize: 16.ssp(),
            ),
          ),
          Text(
            item,
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 16.ssp(),
            ),
          )
        ],
      ),
    );
  }
}
