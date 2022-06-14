import 'package:videomanager/screens/others/exporter.dart';


class CustomContextMenuItems {
CustomContextMenuItems({required this.title, required this.icon, required this.id});
  String title; 
  IconData icon;
  int id;
  
}

class ContextMenuItem extends ConsumerWidget {
   const ContextMenuItem({required this.item, Key? key}) : super(key: key);
  final CustomContextMenuItems item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 49.h,
      child: GestureDetector(
              onTap: () {
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 20.r,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    item.title,
                    style: kTextStyleIbmRegular.copyWith(color: primaryColor),
                  ),
                ],
              ),
            ),
    );
  }
}

















// GestureDetector(
//               onTap: () {
//               },
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Videomanager.assign,
//                     size: 20.r,
//                   ),
//                   SizedBox(
//                     width: 15.w,
//                   ),
//                   Text(
//                     'Assign',
//                     style: kTextStyleIbmRegular.copyWith(color: primaryColor),
//                   ),
//                 ],
//               ),
//             ),