import 'package:get_time_ago/get_time_ago.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar(
      {Key? key,
      this.profileradius = 20,
      this.showDetails = false,
      this.nameFontSize = 14,
      this.isActive = false,
      this.name = 'Full Name',
      this.onTap,
      this.lastActive})
      : super(key: key);
  double profileradius, nameFontSize;
  final bool showDetails, isActive;
  final String name;
  final Function? onTap;
  final DateTime? lastActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : null,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              !showDetails ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: profileradius.sr(),
                  backgroundColor: primaryColor,
                  child: FittedBox(
                    child: Text(
                      processName(name),
                      style: kTextStyleIbmSemiBold.copyWith(
                          color: Colors.white, fontSize: 14.5.ssp()),
                    ),
                  ),
                ),
                Positioned(
                  right: -1,
                  bottom: -2,
                  child: CircleAvatar(
                    radius: (profileradius.sr() * 0.4),
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 0.3 * profileradius.sr(),
                      backgroundColor: isActive ? successColor : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            if (showDetails) ...[
              SizedBox(
                width: 30.sw(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: kTextStyleIbmSemiBold.copyWith(
                        fontSize: nameFontSize.ssp(), color: Colors.black),
                  ),
                  ...[
                    SizedBox(
                      height: 5.sh(),
                    ),
                    isActive
                        ? Text('Online',
                            style: kTextStyleIbmRegularBlack.copyWith(
                                fontSize: 13.ssp()))
                        : lastActive != null
                            ? TimerBuilder.periodic(Duration(minutes: 1),
                                builder: ((context) {
                                var difference =
                                    DateTime.now().difference(lastActive!);
                                if (difference.inSeconds < 60) {
                                  return Text('just now',
                                      style: kTextStyleIbmRegularBlack.copyWith(
                                          fontSize: 13.ssp()));
                                }

                                return Text(
                                  GetTimeAgo.parse(lastActive!),
                                  style: kTextStyleIbmRegularBlack.copyWith(
                                      fontSize: 13.ssp()),
                                );
                              }))
                            : Container(),
                    // Text('',
                    //     style: kTextStyleIbmRegularBlack.copyWith(
                    //         fontSize: 0)),
                  ]
                ],
              )
            ],
          ]),
    );
  }

  String processName(String name) {
    var processedName = '';

    name.split(' ').forEach((element) {
      if (element.isNotEmpty) processedName += element.substring(0, 1);
    });

    return processedName;
  }
}
