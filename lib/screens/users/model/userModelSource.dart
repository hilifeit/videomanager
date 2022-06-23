import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:videomanager/screens/components/customdialogbox/customdialogbox.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';

class UserModelSource extends DataTableSource {
  UserModelSource(
      {required this.context,
      required this.users,
      this.color = dangerSecondary,
      this.status = 'Pending'});

  final BuildContext context;
  final List<UserModel> users;
  Color color;
  String status;
  @override
  DataRow? getRow(int index) {
    if (index >= users.length) {
      return null;
    }

    final user = users[index];

    return DataRow2.byIndex(index: index, cells: [
      DataCell(SizedBox(
        height: 41.sh(),
        child: TableUserCard(user: user),
      )),
      DataCell(Text(
        user.email,
        style: kTextStyleTableSubtitle,
      )),
      DataCell(Text(
        DateFormat('yyyy-MM-dd').format(user.createdAt),
        style: kTextStyleTableSubtitle,
      )),
      DataCell(Status(color: color, status: status)),
      DataCell(
        PopupMenuButton(
            // offset: Offset(0, height / 2 + 22.ssp()),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(onTap: () async {}, child: const Text('Action'))
              ];
            },
            child: Icon(Icons.more_vert)),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
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
  const TableUserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32.sh(),
          width: 32.sw(),
          color: Colors.tealAccent,
        ),
        SizedBox(
          width: 10.sw(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: kTextStyleTableName,
            ),
            Text(
              user.role.toString(),
              style: kTextStyleTableSubtitle,
            ),
          ],
        ),
      ],
    );
  }
}
