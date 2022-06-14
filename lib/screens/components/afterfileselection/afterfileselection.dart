import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/components/afterfileselection/fileitemwidget.dart';
import 'package:videomanager/screens/others/exporter.dart';

List<FileItem> items = [
  FileItem(title: 'Rapti', icon: Videomanager.folder, id: 0),
  FileItem(title: 'Biratnagar', icon: Videomanager.video_file, id: 1),
  FileItem(title: 'kalimati', icon: Videomanager.folder, id: 2),
  FileItem(title: 'Butwal', icon: Videomanager.video_file, id: 3),
];

class AfterFileSelection extends StatelessWidget {
  const AfterFileSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      width: 935.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Items',
            style: kTextStyleIbmRegular.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FileItemWidget(item: items[index]);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 50.w,
                  );
                },
                itemCount: items.length),
          )
        ],
      ),
    );
  }
}
