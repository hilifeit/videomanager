import 'package:data_table_2/data_table_2.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';

class UserTable extends ConsumerWidget {
  UserTable({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final users = ref.watch(userChangeProvider).users;
    return SizedBox(
      // width: double.infinity,
      child: PaginatedDataTable2(
        empty: const Text("No data!"),
        headingRowHeight: 38.sh(),
        dataRowHeight: 58.sh(),
        wrapInCard: false,
        // headingRowColor:
        //     MaterialStateColor.resolveWith((states) => const Color(0xfffbfbfb)),
        // dataRowColor:
        //     MaterialStateColor.resolveWith((states) => const Color(0xfffbfbfb)),
        columns: const [
          DataColumn(label: Text("User")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("JOINING DATE")),
        ],

        source: UserModelSource(context: context, users: users),
      ),
    );
  }
}
