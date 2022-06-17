import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videoquality.dart';

class VideoQualitySelect extends ConsumerWidget {
  VideoQualitySelect({
    Key? key,
    required this.onChanged,
    //required this.item,
  }) : super(key: key);
  //final VideoQualityItem item;
  final selectedProvider = StateProvider<int>((ref) {
    return 0;
  });
  final Function(int val) onChanged;
  @override
  Widget build(BuildContext context, ref) {
    final selected = ref.watch(selectedProvider.state).state;
    return Wrap(
      runSpacing: 29.sr(),
      spacing: 29.sr(),
      children:
          items.map((e) => selectableItem(context, ref, e, selected)).toList(),
    );
  }

  InkWell selectableItem(context, ref, VideoQualityItem item, selected) {
    return InkWell(
        onTap: () {
          ref.read(selectedProvider.state).state = item.id;
          onChanged(item.id);
        },
        child: Container(
          width: 106.sw(),
          height: 49.sh(),
          decoration: BoxDecoration(
              color: selected == item.id
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
