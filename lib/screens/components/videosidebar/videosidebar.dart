import 'package:videomanager/screens/components/helper/overlayentry.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/components/cards.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class VideoSideBAr extends StatelessWidget {
  VideoSideBAr({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ClipPath(
            clipper: CustomREctClipper(
                bigHeight: size.height - 73.sh(),
                bigWidth: 30.sw(),
                bigleft: 0,
                bigtop: 0,
                smallHeight: 155.sh(),
                smallWidth: 30.sw()),
            child: InkWell(
              onTap: () {
                CustomOverlayEntry().closeOverlay();
              },
              child: Container(
                  width: 30.sw(),
                  height: 155.sh(),
                  color: Color(0xffE4F5FF),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                  )),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     closeOverlay();
          //   },
          //   child: Container(
          //       width: 30.sw(),
          //       height: 155.sh(),
          //       color: Color(0xffE4F5FF),
          //       child: Icon(
          //         Icons.chevron_right_rounded,
          //         color: Colors.black,
          //       )),
          // ),
          Container(
            color: Colors.white,
            height: size.height,
            width: 503.sw(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 37.sw(), right: 37.sw(), bottom: 0.sh()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 480.sh(),
                    child: Consumer(builder: (context, ref, c) {
                      final filterSelect =
                          ref.watch(filterItemProvider.state).state;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Videos',
                                style: kTextStyleIbmMedium.copyWith(
                                  fontSize: 18.ssp(),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (filterSelect != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.sw(),
                                      ),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child:
                                          FilterItemWidget(item: filterSelect)),
                                ),
                              FilterIconButton(),
                              //     ),
                            ],
                          ),
                          SizedBox(
                            height: 13.sh(),
                          ),
                          Expanded(
                            child: Consumer(builder: (context, ref, c) {
                              final thisUser = ref
                                  .watch(userChangeProvider)
                                  .loggedInUser
                                  .value;
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return VideoAssignCard(
                                      item: items[index],
                                      thisUser: thisUser!,
                                    );
                                  },
                                  separatorBuilder: (context, _) {
                                    return SizedBox(
                                      height: 8.sh(),
                                    );
                                  },
                                  itemCount: items.length);
                            }),
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}