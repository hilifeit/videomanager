import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/userService.dart';

import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

class AssignUser extends ConsumerWidget {
  AssignUser({
    Key? key,
    required this.files,
    // required this.points,
  }) : super(key: key);
  final List<FileDetailMini> files;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedId = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userChangeProvider);
    userService.getMyUser();
    final myUsers = userService.myUsers;
    final userrMenu =
        myUsers.map((e) => CustomMenuItem(label: e.name, value: e.id)).toList();

    return Container(
      height: 539.sh(),
      width: 593.sw(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sr()),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Row(
                children: [
                  Text(
                    'Assign Users',
                    style: kTextStyleIbmRegular.copyWith(
                      fontSize: 16.ssp(),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 47.sw()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.sh(),
                    ),
                    Center(
                      child: Text(
                        'Please Choose the User from the drop down below',
                        style: kTextStyleIbmRegularBlack.copyWith(
                          fontSize: 16.ssp(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.sh(),
                    ),

                    Text(
                      'User',
                      style: kTextStyleIbmSemiBold,
                    ),
                    SizedBox(
                      height: 6.sh(),
                    ),
                    userrMenu.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: secondaryColor)),
                            child: CustomMenuDropDown(
                                value: userrMenu.first,
                                onChanged: (val) {
                                  selectedId = val.value;
                                },
                                values: userrMenu,
                                helperText: ''),
                          )
                        : const Text("Add Users first"),
                    SizedBox(
                      height: 32.sh(),
                    ),

                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return FileNameComponent(fileDetail: files[index]);
                          },
                          separatorBuilder: (context, _) {
                            return SizedBox(
                              height: 5.sh(),
                            );
                          },
                          itemCount: files.length),
                    ),
                    // Wrap(
                    //     spacing: 10.sw(),
                    //     runSpacing: 10.sh(),
                    //     children: List.generate(
                    //       files.length,
                    //       (index) => Padding(
                    //           padding: EdgeInsets.only(right: 16.sw()),
                    //           child:
                    //               FileNameComponent(fileDetail: files[index])),
                    //     )),
                    SizedBox(
                      height: 45.sh(),
                    ),
                    OutlinedElevatedButtonCombo(
                      outlinedButtonText: 'Cancel',
                      elevatedButtonText: 'Confirm',
                      center: true,
                      onPressedElevated: () {
                        if (selectedId.isEmpty) {
                          selectedId = userrMenu.first.value;
                        }
                        if (_formKey.currentState!.validate()) {
                          var dataMap = {
                            "assignedTo": selectedId,
                            "files": files.map((e) => e.id).toList()
                          };

                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  textSecond: "assign to this user?",
                                  elevatedButtonText: 'Yes',
                                  onPressedElevated: () async {
                                    try {
                                      await ref
                                          .read(fileDetailMiniServiceProvider)
                                          .assignVideosToUser(dataMap);
                                      snack
                                          .success("Area Assigned Succesfully");
                                      Future.delayed(
                                          const Duration(milliseconds: 5), () {
                                        Navigator.pop(context);
                                      });
                                    } catch (e, s) {
                                      print("$e $s");
                                      snack.error(e);
                                    }
                                  },
                                );
                              });
                        }
                      },
                      onPressedOutlined: () {
                        // Navigator.of(context).overlay!.mounted;
                        Navigator.pop(context);
                      },
                      width: 96.sw(),
                      height: 32.sh(),
                      spacing: 19.sw(),
                    ),
                    SizedBox(
                      height: 15.sh(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileNameComponent extends StatelessWidget {
  FileNameComponent({
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
        ],
      ),
    );
  }
}
