import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videomanager/screens/components/contextmenu/contextmenuitemwidget.dart';
import 'package:videomanager/videomanager_icons.dart';



List<CustomContextMenuItems> items = [
  CustomContextMenuItems(title: 'Assign', icon: Videomanager.assign, id: 0),
  CustomContextMenuItems(title: 'Play Video', icon: Videomanager.play_video, id: 1),
  CustomContextMenuItems(title: 'Edit', icon: Videomanager.edit, id: 2),
];

class ContextMenu extends StatelessWidget {
   ContextMenu({Key? key}) : super(key: key);

    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 147.h,
      width: 150.w,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: ListView.separated(itemBuilder: (context,index){
          return ContextMenuItem(item: items[index], );
        }, separatorBuilder: (context, index){
          return const Divider(
                      height: 1,
                      thickness: 0.5,
                    );
        }, itemCount: items.length)
      ),
    );
  }
}


