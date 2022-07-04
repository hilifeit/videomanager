import 'package:videomanager/screens/components/custominfo.dart';
import 'package:videomanager/screens/dashboard/component/filemodelsource.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/dataTable.dart';
import 'package:videomanager/screens/viewscreen/services/fileService.dart';

List<DataColumn> data = [
  DataColumn(
      label: Text(
    "User",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "VIDEO",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "STATUS",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
  DataColumn(
      label: Text(
    "ACTION",
    style: kTextStyleTableTitle.copyWith(fontSize: 12.ssp()),
  )),
];

class CustomTable extends ConsumerWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileService = ref.watch(fileDetailMiniServiceProvider);
    final files = fileService.files;
    print(files.length);
    return Scaffold(
      body: CustomDataTable(
        empty: CustomShowMessage.nodata(),
        column: data,
        source: FileModelSource(
          context: context,
          files: files,
        ),
      ),
    );
  }
}
