import 'package:videomanager/screens/others/exporter.dart';

class Status {
  Status({required this.status, required this.color});
  final String status;
  final Color color;
}

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;
  late Color color;
  List<Status> items = [
    Status(status: 'Pending', color: danger),
    Status(status: 'Complete', color: sucess),
    Status(status: 'Ongoing', color: primaryColor),
    Status(status: 'Approved', color: sucess),
    Status(status: 'Rejected', color: danger)
  ];
  @override
  Widget build(BuildContext context) {
//     for (var element in items) {
// =======
//     for (var element in itemStatus) {
// >>>>>>> b9d715c2dd3f6bb4d7c77c4ab326489f4f8c5940
//       if (element.status == status) {
//         color = element.color;
//         break;
//       }
//     }

    return Container(
      width: 95.sw(),
      height: 22.sh(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sr()),
        color: items[int.parse(status)].color.withOpacity(0.16),
      ),
      child: Center(
        child: Text(
          items[int.parse(status)].status,
          style: kTextStyleIbmMedium.copyWith(
              fontSize: 13.ssp(), color: items[int.parse(status)].color),
        ),
      ),
    );
  }
}
