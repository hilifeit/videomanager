import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videomanager/screens/others/constant.dart';
import 'package:videomanager/screens/viewscreen/filter.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 101.h,
            color: primaryColor,
          ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Filter()),
              Expanded(
                flex: 5,
                child: Placeholder(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        ],
      ),
      ),
    );
    
  }
}