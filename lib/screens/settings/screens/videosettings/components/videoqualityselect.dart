import 'package:videomanager/screens/others/exporter.dart';

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
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 29.sr(),
      spacing: 29.sr(),
      children: VideoQuality.values
          .map((e) => selectableItem(context, ref, e))
          .toList(),
    );
  }

  Widget selectableItem(context, ref, VideoQuality item) {
    return AbsorbPointer(
      absorbing: item.index.isEven,
      child: InkWell(
          onTap: () {
            setState(() {
              value = item.index;
            });
            widget.onChanged(item.index);
          },
          child: Container(
            width: 106.sw(),
            height: 49.sh(),
            decoration: BoxDecoration(
                color: value == item.index
                    ? Theme.of(context).primaryColor.withOpacity(0.15)
                    : lightGrey.withOpacity(0.22),
                borderRadius: BorderRadius.circular(4.sr())),
            child: Center(
              child: Text(
                item.name.replaceAll("q", ''),
                style: value == item.index
                    ? kTextStyleInterRegular.copyWith(
                        fontSize: 18.ssp(),
                        color: Theme.of(context).primaryColor)
                    : kTextStyleInterRegular.copyWith(fontSize: 18.ssp()),
              ),
            ),
          )),
    );
  }
}
