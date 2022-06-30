import 'package:data_table_2/data_table_2.dart';
import 'package:videomanager/screens/components/custominfo.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';
import 'package:videomanager/screens/users/model/userModelSource.dart';

class UserTable extends ConsumerWidget {
  UserTable({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final userService = ref.watch(userChangeProvider);
    final users = userService.users;
    final errorMsg = userService.errorMessage;
    return SizedBox(
      // width: double.infinity,
      child: PaginatedDataTable2(
        
        empty: users == null
            ? CustomShowMessage.nodata()
            : CustomShowMessage.nodata(),
        headingRowHeight: 49.sh(),
        dataRowHeight: 73.sh(),
        wrapInCard: false,

        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),

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
          DataColumn(
              label: Text(
            "ROLE",
            style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
          )),
          DataColumn(
              label: Text(
            "ACTION",
            style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
          )),
        ],

        source: UserModelSource(context: context, users: users ?? []),
      ),
    );
  }
}
