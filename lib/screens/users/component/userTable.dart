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
        dataRowHeight: 56.sh(),
        wrapInCard: false,

        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xfffbfbfb)),

        // headingRowColor:
        //     MaterialStateColor.resolveWith((states) => const Color(0xfffbfbfb)),
        // dataRowColor:
        //     MaterialStateColor.resolveWith((states) => const Color(0xfffbfbfb)),
        columns: [
          DataColumn(
              label: Text(
            "User",
            style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
          )),
          DataColumn(
              label: Text(
            "Email",
            style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
          )),
          DataColumn(
              label: Text(
            "JOINING DATE",
            style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
          )),
        ],

        source: UserModelSource(context: context, users: users),
      ),
    );
  }
}
