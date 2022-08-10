import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class PlayBackMenu extends StatefulWidget {
  const PlayBackMenu({Key? key, required this.onchanged}) : super(key: key);
  final Function(double) onchanged;
  @override
  State<PlayBackMenu> createState() => _PlayBackMenuState();
}

class _PlayBackMenuState extends State<PlayBackMenu> {
  final List<double> playbackspeed = [
    0,
    0.25,
    0.5,
    0.75,
    1,
    1.25,
    1.5,
    1.75,
    2
  ];
  double selectedValue = 1.0;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
        // initialValue: selectedValue,
        constraints: BoxConstraints(maxHeight: 300.sh(), maxWidth: 200.sw()),
        padding: EdgeInsets.zero,
        icon: Icon(
          Videomanager.settings,
          color: Colors.white,
          size: 21.75.ssp(),
        ),
        onSelected: (value) {
          setState(() {
            selectedValue = value;
            widget.onchanged(value);
          });
        },
        itemBuilder: ((context) {
          return playbackspeed.map((e) {
            return PopupMenuItem(
              enabled: e == 0 ? false : true,
              height: 30.sh(),
              padding: EdgeInsets.symmetric(horizontal: 10.sw()),
              value: e,
              child: e == 0
                  ? Container(
                      width: 243.sw(),
                      child: Row(
                        children: [
                          Theme(
                            data: ThemeData(),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).primaryColor,
                                  size: 14.ssp(),
                                )),
                          ),
                          Text(
                            'Playback Speed',
                            style: kTextStyleIbmRegular.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14.ssp()),
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
                    )
                  : Row(
                      children: [
                        Icon(Icons.check,
                            color: selectedValue == e
                                ? Theme.of(context).primaryColor
                                : Colors.transparent),
                        SizedBox(
                          width: 20.sw(),
                        ),
                        Text(
                          e.toString(),
                          style: kTextStyleIbmRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14.ssp()),
                        ),
                      ],
                    ),
            );
          }).toList();
        }));
  }
}
