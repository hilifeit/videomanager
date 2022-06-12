import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/viewscreen/components/map.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8F8F8),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
                    color: Color(0xffF8F8F8),
                    ),
          ),
          Expanded(
            flex: 2,
            child: MapScreen(isvisible: false,))

        ],
      ),
    );
    
  }
}