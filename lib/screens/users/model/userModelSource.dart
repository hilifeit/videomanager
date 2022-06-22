import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/model/usermodel.dart';

class UserModelSource extends DataTableSource {
  UserModelSource({required this.context, required this.users});

  final BuildContext context;
  final List<UserModel> users;
  @override
  DataRow? getRow(int index) {
    if (index >= users.length) {
      return null;
    }

    final user = users[index];
    return DataRow2.byIndex(index: index, cells: [
      DataCell(SizedBox(
        height: 41.sh(),
        child: Row(
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
        ),
      )),
      DataCell(Text(
        user.email,
        style: kTextStyleTableSubtitle,
      )),
      DataCell(Text(
        DateFormat('yyyy-MM-dd').format(user.createdAt),
        style: kTextStyleTableSubtitle,
      )),
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
