import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/components/Sidebar/components/statuswidget.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/viewscreen/models/areaModel.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/components/analysisHub.dart';
import 'package:videomanager/screens/viewscreen/screens/analysis/components/analysisMap.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';
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
    return GestureDetector(
      onSecondaryTapUp: (detail) {
        Offset globalPostion = detail.globalPosition;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(globalPostion.dx, globalPostion.dy,
              globalPostion.dx + 1, globalPostion.dy + 1),
          items: [
            PopupMenuItem(
              onTap: () async {
                //  var fileService = ref.read(fileDetailMiniServiceProvider);
                var selectedAreaService = ref.read(selectedAreaServiceProvider);
                selectedAreaService.refine();
                var selectedArea = selectedAreaService.refinedSelection.value;

                Future.delayed(const Duration(milliseconds: 300), () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 0.1,
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * .65,
                            child: AnalysisHub(
                              files: selectedArea,
                            ),
                          ),
                        );
                      });
                });
              },
              child: CustomPopUpMenuItemChild(
                icon: Videomanager.assign,
                text: "Analyze Area",
              ),
            ),
            PopupMenuItem(
              child: CustomPopUpMenuItemChild(
                icon: Videomanager.assign,
                text: "Delete Area",
              ),
              onTap: () async {
                // Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 10), () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          textSecond: 'delete this Area?',
                          elevatedButtonText: "Yes",
                          onPressedElevated: () async {
                            try {
                              await ref
                                  .read(fileDetailMiniServiceProvider)
                                  .deleteArea(id: area.id);

                              ref
                                  .read(fileDetailMiniServiceProvider)
                                  .fetchAllArea();
                              snack.success('Area Deleted Sucessfully');
                            } catch (e) {
                              snack.error(e);
                            }
                          },
                        );
                      });
                });
              },
            ),
          ],
        );
      },
      onTap: () {
        var selectedAreaService = ref.read(selectedAreaServiceProvider);
        var areas = ref.read(fileDetailMiniServiceProvider).areas;
        var selectedPoints = selectedAreaService.selectedPoints;
        if (selectedAreaService.selectedArea.value != area) {
          AreaModel? thisArea;
          for (var element in areas) {
            if (selectedAreaService.selectedArea.value == element) {
              thisArea = element;
            }
          }

          bool edit = false;
          if (selectedPoints.isNotEmpty && thisArea != null) {
            for (var element in thisArea.location.coordinates) {
              int index = thisArea.location.coordinates.indexOf(element);
              if (selectedPoints[index].latitude != element.last &&
                  selectedPoints[index].longitude != element.first) {
                edit = true;
              }
            }
          }
          if (!edit) {
            selectedAreaService
              ..selectArea(area)
              ..refine();
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    elevatedButtonText: "Confirm",
                    onPressedElevated: () {
                      selectedAreaService
                        ..selectArea(area)
                        ..refine();
                    },
                    textSecond: 'discard changes to this Area?',
                  );
                });
          }
        }
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
                  '${area.files}',
                  style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 14.ssp(), color: whiteColor),
                ),
              ),
              SizedBox(
                width: 10.sw(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              ),
              // Spacer(),
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
