import 'dart:math';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class BugScreen extends StatelessWidget {
  BugScreen({Key? key}) : super(key: key);
  final List<String> title = ['Username', 'Name', 'Role', 'Description'];
  final List<String> content = [
    'user1',
    'Shruti Pokharel',
    'User',
    'Bugs found'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightGrey,
        child: ListView.separated(
            itemBuilder: (context, index) {
              if (index != title.length - 1) {
                return Column(
                  children: [
                    Text(title[index]),
                    SizedBox(
                      height: 6.h,
                    ),
                    SingleRoleText(
                        text: content[index], style: kTextStyleIbmRegularBlack)
                  ],
                  // children: title.map((e) => Text(e)).toList(),
                );
              } else {
                return Column(
                  children: [
                    Text(title[index]),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      height: 200.h,
                      child: SingleRoleText(
                          text: content[index],
                          style: kTextStyleIbmRegularBlack),
                    ),
                  ],
                );
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 14.h);
            },
            itemCount: title.length));
  }
}

class SingleRoleText extends StatelessWidget {
  SingleRoleText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.sh(),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4.sr(),
        ),
        border: Border.all(
          color: lightGrey,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13.sw(), bottom: 10.sh(), top: 10.sh()),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: style),
        ),
      ),
    );
  }
}
