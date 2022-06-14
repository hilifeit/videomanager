import 'package:videomanager/screens/others/exporter.dart';

class FileItem {
  FileItem({required this.title, required this.icon, required this.id});
  String title;
  IconData icon;
  int id;
}

class FileItemWidget extends ConsumerWidget {
  const FileItemWidget({required this.item, Key? key}) : super(key: key);
  final FileItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 50.r,
            color: const Color(0xffFFD782),
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            item.title,
            style: kTextStyleIbmRegularBlack.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
