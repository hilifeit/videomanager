import 'package:videomanager/screens/others/exporter.dart';

class CustomDropDown<T> extends StatelessWidget {
  CustomDropDown(
      {Key? key,
      required this.text,
      required this.value,
      required this.onChanged,
      required this.values,
      required this.helperText})
      : super(key: key);

  final String text;
  final T value;
  final Function(dynamic val) onChanged;
  final List<T> values;
  final String helperText;

  late final valueProvider = StateProvider<T>((ref) {
    return value;
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.sw(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kTextStyleInterRegular.copyWith(fontSize: 16.ssp()),
          ),
          Consumer(builder: (context, ref, c) {
            final selectedValue = ref.watch(valueProvider.state).state;
            return SizedBox(
              width: 106.sw(),
              height: 49.sh(),
              child: Container(
                color: lightWhite.withOpacity(0.22),
                child: DropdownButton<T>(
                    selectedItemBuilder: (context) {
                      return values
                          .map((e) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sw(), vertical: 12.sh()),
                                child: Text(
                                  "$e $helperText",
                                  style: kTextStyleInterRegular.copyWith(
                                      fontSize: 18.ssp()),
                                ),
                              ))
                          .toList();
                    },
                    // isExpanded: true,
                    underline: Container(),
                    value: selectedValue,
                    icon: Expanded(
                      child: Icon(
                        Videomanager.down,
                        size: 8.5.sr(),
                        color: Colors.black,
                      ),
                    ),
                    items: values.map<DropdownMenuItem<T>>((val) {
                      return DropdownMenuItem<T>(
                        value: val,
                        child: Text(val.toString()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      ref.read(valueProvider.state).state = val as T;

                      onChanged(val);
                    }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
