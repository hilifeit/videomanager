import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videomanager/screens/others/constant.dart';
import 'package:videomanager/screens/viewscreen/components/filter.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 1, child: Filter()),
                  Expanded(flex: 5, child: MapScreen())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
