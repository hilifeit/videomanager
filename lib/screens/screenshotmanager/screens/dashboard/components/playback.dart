import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class Playback extends StatefulWidget {
  Playback({Key? key, required this.onChanged}) : super(key: key);
  // bool isSelected=false;
  final Function(double) onChanged;
  @override
  State<Playback> createState() => _PlaybackState();
}

class _PlaybackState extends State<Playback> {
  final List<double> playbackspeed = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2];
  double selectedValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // width: 248.sw(),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: primaryColor,
                      size: 14.ssp(),
                    )),
                Text(
                  'Playback Speed',
                  style: kTextStyleIbmRegular.copyWith(
                      color: primaryColor, fontSize: 14.ssp()),
                ),
                Spacer(),
                // TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       'Custom',
                //       style: kTextStyleIbmRegular.copyWith(
                //           color: primaryColor,
                //           decoration: TextDecoration.underline,
                //           fontSize: 14.ssp()),
                //     ))
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: playbackspeed.map((e) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.sh()),
                          child: InkWell(
                            onTap: () {
                              print(e);
                              setState(() {
                                selectedValue = e;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.check,
                                    color: selectedValue == e
                                        ? primaryColor
                                        : Colors.transparent),
                                SizedBox(
                                  width: 20.sw(),
                                ),
                                Text(
                                  e.toString(),
                                  style: kTextStyleIbmRegular.copyWith(
                                      color: primaryColor, fontSize: 14.ssp()),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
