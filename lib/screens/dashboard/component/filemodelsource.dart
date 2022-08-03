import 'package:data_table_2/data_table_2.dart';

import 'package:videomanager/screens/others/exporter.dart';

import 'package:videomanager/screens/users/model/usermodelmini.dart';

import 'package:videomanager/screens/viewscreen/models/filedetailmini.dart';

final editManagerSelectProvider = StateProvider<bool>((ref) {
  return false;
});

class FileModelSource extends DataTableSource {
  FileModelSource(
      {required this.context,
      // required this.user,
      required this.files,
      this.color = dangerSecondary,
      this.status = 'Pending'});

  final BuildContext context;
  // final UserModelMini user;
  final List<FileDetailMini> files;

  Color color;
  String status;
  @override
  DataRow? getRow(int index) {
    if (index >= files.length) {
      return null;
    }

    final file = files[index];
    // print(file.filename);
    return DataRow2.byIndex(index: index, cells: [
      DataCell(SizedBox(
        height: 41.sh(),
        child: TableUserCard(),
      )),
      DataCell(
        Text(
          file.filename,
          style: kTextStyleTableSubtitle,
        ),
      ),
      DataCell(Status(color: color, status: status)),
      DataCell(
        Consumer(builder: (context, ref, c) {
          return PopupMenuButton(
              offset: const Offset(0, 0),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      onTap: () async {},
                      child: CustomPopUpMenuItemChild(
                        icon: Videomanager.edit,
                        text: 'Edit',
                      )),
                  PopupMenuItem(
                      onTap: () {},
                      child: CustomPopUpMenuItemChild(
                        icon: Videomanager.delete,
                        text: 'Delete',
                      )),
                ];
              },
              child: const Icon(Icons.more_vert));
        }),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => files.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class CustomPopUpMenuItemChild extends StatelessWidget {
  CustomPopUpMenuItemChild({
    Key? key,
    this.width,
    this.icon,
    required this.text,
  }) : super(key: key);
  double? width;
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.sh(),
      width: width ?? 180.sw(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 17.6.sr(),
          ),
          SizedBox(
            width: 21.3.sw(),
          ),
          Text(
            text,
            style: kTextStyleIbmRegular.copyWith(
              fontSize: 16.ssp(),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
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

class TableUserCard extends StatelessWidget {
  TableUserCard({
    Key? key,
    this.user,
  }) : super(key: key);

  UserModelMini? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: kTextStyleTableName,
        ),
      ],
    );
  }
}
