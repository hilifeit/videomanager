import 'package:data_table_2/data_table_2.dart';
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
      DataCell(Text(user.name)),
      DataCell(Text(user.email)),
      DataCell(Text(user.createdAt.toString())),
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
