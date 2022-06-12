import 'package:flutter/material.dart';
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
        child: Row(
          children: [
            Expanded(
              child: Filter(),
            ),
            Expanded(
                flex: 5,
                child: MapScreen(
                  isvisible: true,
                ))
          ],
        ),
      ),
    );
  }
}