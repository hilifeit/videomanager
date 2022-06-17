import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videoquality.dart';

class VideoQualitySelect extends ConsumerStatefulWidget {
  const VideoQualitySelect({
    Key? key,
    required this.value,
    required this.onChanged,
    //required this.item,
  }) : super(key: key);

  final Function(int val) onChanged;
  final int value;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoQualitySelectState();
}

class _VideoQualitySelectState extends ConsumerState<VideoQualitySelect> {
  int value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 29.sr(),
      spacing: 29.sr(),
      children: items.map((e) => selectableItem(context, ref, e)).toList(),
    );
  }

  InkWell selectableItem(context, ref, VideoQualityItem item) {
    return InkWell(
        onTap: () {
          setState(() {
            value = item.id;
          });
          widget.onChanged(item.id);
        },
        child: Container(
          width: 106.sw(),
          height: 49.sh(),
          decoration: BoxDecoration(
              color: value == item.id
                  ? Theme.of(context).primaryColor.withOpacity(0.15)
                  : lightWhite.withOpacity(0.22),
              borderRadius: BorderRadius.circular(4.sr())),
          child: Center(
            child: Text(
              item.text,
            ),
          ),
        ));
  }
}
