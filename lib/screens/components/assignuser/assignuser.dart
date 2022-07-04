import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';
import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

class AssignUser extends ConsumerWidget {
  AssignUser({
    Key? key,
    this.fileDetail,
  }) : super(key: key);
  FileDetailMini? fileDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userChangeProvider);
    final allManagers = userService.getByRoles(Roles.manager);
    final managerMenu = allManagers
        .map((e) => CustomMenuItem(label: e.name, value: e.id))
        .toList();
    // print(allUsers.length);
    // final index = user.length;
    // print(index);

    return Container(
      height: 539.sh(),
      width: 593.sw(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sr()),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left: 80.sw(), top: 9.sh()),
          height: 42.sh(),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sr()),
                topRight: Radius.circular(8.sr())),
          ),
          child: Text(
            'Assign Users',
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 16.ssp(),
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 47.sw()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.sh(),
                ),
                Center(
                  child: Text(
                    'Please Choose the user from the drop down below',
                    style: kTextStyleIbmRegularBlack.copyWith(
                      fontSize: 16.ssp(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.sh(),
                ),
                Text(
                  fileDetail == null ? 'Areaname' : fileDetail!.filename,
                  style: kTextStyleIbmRegular.copyWith(
                    fontSize: 16..ssp(),
                    color: danger,
                  ),
                ),
                SizedBox(
                  height: 29.sh(),
                ),
                Text(
                  'User',
                  style: kTextStyleIbmSemiBold,
                ),
                SizedBox(
                  height: 6.sh(),
                ),
                managerMenu.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor)),
                        child: CustomMenuDropDown(
                            value: managerMenu.first,
                            onChanged: (val) {},
                            values: managerMenu,
                            helperText: ''),
                      )
                    : const Text("Add Managers first"),
                SizedBox(
                  height: 32.sh(),
                ),
                Wrap(
                  spacing: 12.sw(),
                  runSpacing: 20.sh(),
                  children: [
                    AssignedDetail(fileDetail: fileDetail),
                    AssignedDetail(
                      fileDetail: fileDetail,
                    ),
                    AssignedDetail(
                      fileDetail: fileDetail,
                    ),
                    AssignedDetail(fileDetail: fileDetail),
                  ],
                ),
                SizedBox(
                  height: 58.sh(),
                ),
                OutlinedElevatedButtonCombo(
                  outlinedButtonText: 'Cancel',
                  elevatedButtonText: 'Confirm',
                  center: true,
                  onPressedElevated: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            elevatedButtonText: 'Yes',
                            onPressedElevated: () {},
                          );
                        });
                  },
                  onPressedOutlined: () {
                    // Navigator.of(context).overlay!.mounted;
                    // Navigator.pop(context);
                  },
                  width: 96.sw(),
                  height: 32.sh(),
                  spacing: 19.sw(),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AssignedDetail extends StatelessWidget {
  AssignedDetail({
    Key? key,
    required this.fileDetail,

    // this.isOngoing = false
  }) : super(key: key);

  final FileDetailMini? fileDetail;
  // bool isOngoing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.sw(), 12.sh(), 10.sw(), 9.sh()),
      height: 42.sh(),
      decoration: BoxDecoration(
        color: const Color(0x0D40667D),
        borderRadius: BorderRadius.circular(
          6.sr(),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fileDetail == null ? 'Areaname' : fileDetail!.filename,
            style: kTextStyleIbmRegular.copyWith(
                fontSize: 16.ssp(), color: Colors.black),
          ),
          SizedBox(
            width: 14.sw(),
          ),
          Text(
            '(Assigned)',
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 14.ssp(),
              color: const Color(0xff17A2B8),
            ),
          )
        ],
      ),
    );
  }
}
