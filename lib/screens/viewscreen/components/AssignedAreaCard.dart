import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';
import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
import 'package:videomanager/screens/viewscreen/services/selectedAreaservice.dart';

class AssignedAreaCard extends ConsumerWidget {
  AssignedAreaCard({
    Key? key,
    required this.area,
    this.selected = false,
  }) : super(key: key);

  final AreaModel area;
  bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onLongPress: () {},
      onTap: () {
        var selectedAreaService = ref.read(selectedAreaServiceProvider);
        selectedAreaService
          ..selectArea(area)
          ..refine();
      },
      child: Card(
        color: selected ? Color(0xffECF0F2) : whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20.sr(),
                backgroundColor: notExactlyPrimary,
                child: Text(
                  '200',
                  style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 14.ssp(), color: whiteColor),
                ),
              ),
              SizedBox(
                width: 10.sw(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area.name,
                    style: kTextStyleIbmMedium.copyWith(
                      fontSize: 15.ssp(),
                      color: notExactlyPrimary,
                    ),
                  ),
                  Text(
                    area.assignedTo.name,
                    style: kTextStyleIbmMedium.copyWith(
                      fontSize: 13.ssp(),
                      color: greyish,
                    ),
                  ),
                ],
              ),
              Spacer(),
              StatusCard(
                status: area.status.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
