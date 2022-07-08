import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';

final List<CustomMenuItem> category = [
  CustomMenuItem(
    label: "Kirana",
    value: 0.toString(),
  ),
  CustomMenuItem(
    label: "WholeSale",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "Department Store",
    value: 2.toString(),
  ),
];
final List<CustomMenuItem> shopSize = [
  CustomMenuItem(
    label: "1 shutter",
    value: 0.toString(),
  ),
  CustomMenuItem(
    label: "2 shutter",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "3 shutter",
    value: 2.toString(),
  ),
];

class MarkerColor {
  MarkerColor({required this.color, required this.onselect});
  Color color;
  Function onselect;
}

final markercolorProvider = StateProvider<Color>((ref) {
  return primaryColor;
});

class AddEditShop extends ConsumerWidget {
  AddEditShop({
    this.shop,
    this.edit = false,
    Key? key,
  }) : super(key: key);
  Shop? shop;
  bool edit;
  late CustomMenuItem editCategory;
  late CustomMenuItem editShopSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerColor = ref.watch(markercolorProvider.state).state;
    int colorIndex = 0;
    List<MarkerColor> colors = [
      MarkerColor(
          color: primaryColor,
          onselect: () {
            ref.read(markercolorProvider.state).state = primaryColor;
          }),
      MarkerColor(
          color: Colors.red,
          onselect: () {
            ref.read(markercolorProvider.state).state = Colors.red;
          }),
      MarkerColor(
          color: Colors.amber,
          onselect: () {
            ref.read(markercolorProvider.state).state = Colors.amber;
          }),
      MarkerColor(
          color: Colors.blue,
          onselect: () {
            ref.read(markercolorProvider.state).state = Colors.blue;
          }),
      MarkerColor(
          color: Color(0xffB5FFF6),
          onselect: () {
            ref.read(markercolorProvider.state).state = Color(0xffB5FFF6);
          }),
    ];
    // dd = category.firstWhere((element) => element.label == shop!.category);
    if (edit) {
      for (var element in category) {
        if (element.label == shop!.category) {
          editCategory = category[category.indexOf(element)];
          break;
        }
      }
      for (var element in shopSize) {
        if (element.label == shop!.shopSize) {
          editShopSize = shopSize[shopSize.indexOf(element)];
          break;
        }
      }
      ref.read(markercolorProvider.state).state = shop!.color;
    }

    for (var element in colors) {
      if (element.color == markerColor) {
        colorIndex = colors.indexOf(element);
        break;
      }
    }

    return Container(
      height: 550.sh(),
      width: 525.sw(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sr()),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(left: 24.sw(), right: 29.sw()),
          height: 42.sh(),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sr()),
                topRight: Radius.circular(8.sr())),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                edit ? 'Edit Shop' : 'Add shop',
                style: kTextStyleIbmRegular.copyWith(
                  fontSize: 16.ssp(),
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.ssp(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20.5.sw(), vertical: 5.sh()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(
                value: edit ? shop!.shopName : '',
                fillColor: Colors.white,
                title: 'Shop Name',
                isVisible: true,
                onChanged: (val) {
                  shop!.shopName = val;
                },
              ),
              SizedBox(
                height: 20.5.sh(),
              ),
              Text(
                'Category',
                style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
              ),
              SizedBox(
                height: 7.sh(),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.sr()),
                    border: Border.all(
                      color: lightGrey,
                    )),
                child: CustomMenuDropDown(
                    icon: Icon(
                      Icons.expand_more,
                      size: 20.sr(),
                      color: darkGrey,
                    ),
                    value: edit ? editCategory : category.first,
                    onChanged: (val) {
                      shop!.category = val.label;
                    },
                    values: category,
                    helperText: ""),
              ),
              SizedBox(
                height: 21.sh(),
              ),
              Text(
                'Shop Size',
                style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
              ),
              SizedBox(
                height: 7.sh(),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.sr()),
                    border: Border.all(
                      color: lightGrey,
                    )),
                child: CustomMenuDropDown(
                    icon: Icon(
                      Icons.expand_more,
                      size: 20.sr(),
                      color: darkGrey,
                    ),
                    value: edit ? editShopSize : shopSize.first,
                    onChanged: (val) {
                      shop!.shopSize = val.label;
                    },
                    values: shopSize,
                    helperText: ""),
              ),
              SizedBox(
                height: 20.5.sh(),
              ),
              Text(
                'Marker Colors',
                style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
              ),
              SizedBox(
                height: 23.sh(),
              ),
              Wrap(
                  children: List.generate(
                colors.length,
                (index) => colorIndex == index
                    ? Padding(
                        padding: EdgeInsets.only(right: 16.sw()),
                        child: Container(
                          height: 30.sr(),
                          width: 30.sr(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sr()),
                              border: Border.all(
                                color: colors[index].color,
                              )),
                          child: Icon(
                            Videomanager.brush,
                            size: 16.15.ssp(),
                            color: colors[index].color,
                          ),
                        ))
                    : Padding(
                        padding: EdgeInsets.only(right: 16.sw()),
                        child: SelectMarkerColor(
                          radius: 15.sr(),
                          item: colors[index],
                        ),
                      ),
              )),
              SizedBox(
                height: 20.sh(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomElevatedButton(
                    width: 120.sw(),
                    height: 49.sh(),
                    elevatedButtonTextStyle: kTextStyleInterMedium.copyWith(
                        fontSize: 20.ssp(), color: Colors.white),
                    onPressedElevated: () {
                      shop!.color = markerColor;

                      // TODO : save
                    },
                    elevatedButtonText: 'Save'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class SelectMarkerColor extends StatelessWidget {
  SelectMarkerColor({
    Key? key,
    required this.item,
    required this.radius,
  }) : super(key: key);
  final MarkerColor item;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item.onselect();
      },
      child: CircleAvatar(
        backgroundColor: item.color,
        radius: radius,
      ),
    );
  }
}
