import 'package:videomanager/screens/chat/models/messageCard.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/customSearch.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(20.sw()),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.ssp()),
              child: Row(
                children: [
                  Text(
                    'Chats',
                    style: kTextStyleIbmMedium.copyWith(
                      fontSize: 14.ssp(),
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  if (ResponsiveLayout.isMobile)
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Videomanager.search,
                        color: lightBlack,
                        size: 14.ssp(),
                      ),
                    ),
                ],
              ),
            ),
            if (!ResponsiveLayout.isMobile) ...[
              // SizedBox(
              //   height: 20.sh(),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.sw()),
                child: Container(
                  child: CustomSearch(),
                  // color: darkGrey,
                  height: 35.sh(),
                ),
              ),
              SizedBox(
                height: 20.sh(),
              ),
            ],
            Expanded(
              child: ListView.separated(
                  itemBuilder: ((context, index) {
                    return UserMessageCard();
                  }),
                  separatorBuilder: ((context, index) => Divider(
                        thickness: 2,
                        height: 20.sh(),
                      )),
                  itemCount: 5),
            ),
          ],
        ));
  }
}
