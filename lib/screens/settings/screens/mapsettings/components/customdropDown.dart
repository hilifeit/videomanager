import 'package:videomanager/screens/others/exporter.dart';

class CustomMenuItem {
  CustomMenuItem({
    required this.label,
    required this.value,
  });
  late final String label;
  late final String value;
}

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown(
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
            return SizedBox(
                width: 106.sw(),
                height: 49.sh(),
                child: DropDown<T>(
                    value: value,
                    onChanged: onChanged,
                    values: values,
                    helperText: helperText));
          }),
        ],
      ),
    );
  }
}

class DropDown<T> extends ConsumerWidget {
  DropDown({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.values,
    required this.helperText,
  }) : super(key: key);
  final T value;
  late final valueProvider = StateProvider<T>((ref) {
    return value;
  });
  final Function(dynamic val) onChanged;
  final List<T> values;
  final String helperText;

  @override
  Widget build(BuildContext context, ref) {
    final selectedValue = ref.watch(valueProvider.state).state;
    final icon = Icon(
      Videomanager.down,
      size: 8.5.sr(),
      color: Colors.black,
    );
    return Container(
      color: helperText != '' ? lightGrey.withOpacity(0.22) : Colors.white,
      child: DropdownButton<T>(
          selectedItemBuilder: (context) {
            return values
                .map((e) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sw(), vertical: 12.sh()),
                      child: FittedBox(
                        child: Text(
                          "$e $helperText",
                          style: kTextStyleIbmRegular.copyWith(
                              fontSize: 18.ssp(), color: Colors.black),
                        ),
                      ),
                    ))
                .toList();
          },
          isExpanded: helperText != '' ? false : true,
          underline: Container(),
          value: selectedValue,
          icon: helperText != ''
              ? Expanded(
                  child: icon,
                )
              : Padding(
                  padding: EdgeInsets.only(right: 24.sw()),
                  child: icon,
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
    );
  }
}

class CustomMenuDropDown extends ConsumerWidget {
  CustomMenuDropDown({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.values,
    required this.helperText,
    this.icon,
  }) : super(key: key);
  final CustomMenuItem value;
  late final valueProvider = StateProvider<CustomMenuItem>((ref) {
    return value;
  });
  final Function(CustomMenuItem val) onChanged;
  final List<CustomMenuItem> values;
  final String helperText;
  final Icon? icon;
  late var initState = init();

  init() {
    onChanged(value);
  }

  @override
  Widget build(BuildContext context, ref) {
    final selectedValue = ref.watch(valueProvider.state).state;

    return Container(
      height: 55.sh(),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4.sr(),
        ),
        border: Border.all(
          color: lightGrey,
        ),
        color: Colors.white,
      ),
      child: DropdownButton<CustomMenuItem>(
          selectedItemBuilder: (context) {
            return values.map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.sw(), vertical: 12.sh()),
                child: Text(
                  "${e.label} $helperText",
                  style: kTextStyleIbmMedium.copyWith(
                      fontSize: 16.ssp(), color: Colors.black),
                ),
              );
            }).toList();
          },
          isExpanded: true,
          underline: Container(),
          value: selectedValue,
          icon: Padding(
            padding: EdgeInsets.only(right: 24.sw()),
            child: icon ??
                Icon(
                  Videomanager.down,
                  size: 8.5.sr(),
                  color: Colors.black,
                ),
          ),
          items: values.map<DropdownMenuItem<CustomMenuItem>>((vall) {
            return DropdownMenuItem<CustomMenuItem>(
              value: vall,
              child: Text(vall.label),
            );
          }).toList(),
          onChanged: (val) {
            ref.read(valueProvider.state).state = val as CustomMenuItem;

            onChanged(val);
          }),
    );
  }
}

class TestDropDown extends ConsumerWidget {
  TestDropDown({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.values,
    required this.helperText,
    this.icon,
  }) : super(key: key);
  final CustomMenuItem value;
  late final valueProvider = StateProvider<CustomMenuItem>((ref) {
    return value;
  });
  final Function(CustomMenuItem val) onChanged;
  final List<CustomMenuItem> values;
  final String helperText;
  Icon? icon;

  @override
  Widget build(BuildContext context, ref) {
    final selectedValue = ref.watch(valueProvider.state).state;

    return Container(
      height: 55.sh(),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4.sr(),
        ),
        border: Border.all(
          color: lightGrey,
        ),
        color: helperText != '' ? lightGrey.withOpacity(0.22) : Colors.white,
      ),
      child: DropdownButton<CustomMenuItem>(
          hint: Container(
            padding: EdgeInsets.all(7.sr()),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4.sr())),
            child: Icon(Videomanager.filter, color: Colors.white),
          ),
          selectedItemBuilder: (context) {
            return values.map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.sw(), vertical: 12.sh()),
                child: Text(
                  "${e.label} $helperText",
                  style: kTextStyleIbmSemiBold.copyWith(
                      fontSize: 16.ssp(), color: Colors.black),
                ),
              );
            }).toList();
          },
          isExpanded: helperText != '' ? false : true,
          underline: Container(),
          value: selectedValue,
          items: values.map<DropdownMenuItem<CustomMenuItem>>((vall) {
            return DropdownMenuItem<CustomMenuItem>(
              value: vall,
              child: Text(vall.label),
            );
          }).toList(),
          onChanged: (val) {
            ref.read(valueProvider.state).state = val as CustomMenuItem;

            onChanged(val);
          }),
    );
  }
}
