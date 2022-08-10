import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/models/shops.dart';
import 'package:videomanager/screens/settings/screens/mapsettings/components/customdropDown.dart';
import 'package:videomanager/screens/users/component/adduserform.dart';

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
    label: "1",
    value: 0.toString(),
  ),
  CustomMenuItem(
    label: "2",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "3",
    value: 2.toString(),
  ),
];

final List<CustomMenuItem> roadFace = [
  CustomMenuItem(
    label: "1",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "2",
    value: 2.toString(),
  ),
  CustomMenuItem(
    label: "3",
    value: 3.toString(),
  ),
];
final List<CustomMenuItem> roadFaceSide = [
  CustomMenuItem(
    label: "0.5",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "1",
    value: 2.toString(),
  ),
  CustomMenuItem(
    label: "1.5",
    value: 3.toString(),
  ),
  CustomMenuItem(
    label: "2",
    value: 4.toString(),
  ),
  CustomMenuItem(
    label: "2.5",
    value: 5.toString(),
  ),
];

class MarkerColor {
  MarkerColor({required this.color, required this.onselect});
  Color color;
  Function onselect;
}

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
  late CustomMenuItem editRoadFaceNum;
  late CustomMenuItem editRoadFace1;
  late CustomMenuItem editRoadFace2;
  late CustomMenuItem editRoadFace3;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final markercolorProvider = StateProvider<Color>((ref) {
    return primaryColor;
  });
  final shopProvider = StateProvider<Shop>((ref) {
    return Shop(
        shopName: "",
        category: 1,
        shopSize: 1,
        roadFaceNum: 1,
        roadFace: RoadFace(roadFace1: 1),
        color: primaryColor,
        position: Offset(0, 0));
  });
  final roadFace2Provider = StateProvider<bool>((ref) {
    return false;
  });
  final roadFace3Provider = StateProvider<bool>((ref) {
    return false;
  });

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerColor = ref.watch(markercolorProvider.state).state;
    final addNewShop = ref.watch(shopProvider.state).state;
    final roadFace2Show = ref.watch(roadFace2Provider.state).state;
    final roadFace3Show = ref.watch(roadFace3Provider.state).state;
    if (edit) {
      addNewShop
        ..shopName = shop!.shopName
        ..category = shop!.category
        ..shopSize = shop!.shopSize
        ..phone = shop!.phone
        ..roadFaceNum = shop!.roadFaceNum
        ..roadFace = shop!.roadFace
        ..color = shop!.color;
    }

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
      // if (shop!.roadFaceNum == 2) {
      //   ref.read(roadFace2Provider.state).state = true;
      //   ref.read(roadFace3Provider.state).state = false;
      //   addNewShop.roadFace.roadFace2 = 1;
      // } else if (shop!.roadFaceNum == 3) {
      //   ref.read(roadFace2Provider.state).state = true;
      //   ref.read(roadFace3Provider.state).state = true;
      //   addNewShop.roadFace.roadFace2 = 1;
      //   addNewShop.roadFace.roadFace3 = 1;
      //   // print(roadFaceShow);

      // } else {
      //   // for (int i = 0; i < roadFaceShow.length; i++) {
      //   ref.read(roadFace2Provider.state).state = false;
      //   ref.read(roadFace3Provider.state).state = false;

      //   // }
      // }

      for (var element in category) {
        if (element.label == shop!.category) {
          editCategory = category[category.indexOf(element)];
          break;
        }
      }
      for (var element in shopSize) {
        if (element.label == shop!.shopSize.toString()) {
          editShopSize = shopSize[shopSize.indexOf(element)];
          break;
        }
      }
      for (var element in roadFace) {
        if (element.label == shop!.roadFaceNum.toString()) {
          editRoadFaceNum = roadFace[roadFace.indexOf(element)];
          break;
        }
      }
      for (var element in roadFaceSide) {
        if (element.label == shop!.roadFace.roadFace1.toString()) {
          editRoadFace1 = roadFaceSide[roadFaceSide.indexOf(element)];
          break;
        }
      }
      for (var element in roadFaceSide) {
        if (shop!.roadFace.roadFace2 != null) {
          if (element.label == shop!.roadFace.roadFace2.toString()) {
            editRoadFace2 = roadFaceSide[roadFaceSide.indexOf(element)];
            break;
          }
        } else {
          editRoadFace2 = roadFaceSide.first;
        }
      }
      for (var element in roadFaceSide) {
        if (shop!.roadFace.roadFace3 != null) {
          if (element.label == shop!.roadFace.roadFace3.toString()) {
            editRoadFace3 = roadFaceSide[roadFaceSide.indexOf(element)];
            break;
          }
        } else {
          editRoadFace3 = roadFaceSide.first;
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

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 845.sh(),
        width: 525.sw(),
        decoration: BoxDecoration(
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
                CloseButton(
                  color: Colors.white,
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Icon(
                //     Icons.close,
                //     color: Colors.white,
                //     size: 18.ssp(),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: whiteColor,
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.5.sw(), vertical: 5.sh()),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.sh(),
                          ),
                          InputTextField(
                            value: edit ? shop!.shopName : '',
                            fillColor: Colors.white,
                            title: 'Shop Name',
                            isVisible: true,
                            validator: (val) => validateShop(val!),
                            onChanged: (val) {
                              addNewShop.shopName = val;
                            },
                          ),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          Text(
                            'Category',
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp()),
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
                                  addNewShop.category = int.parse(val.label);
                                },
                                values: category,
                                helperText: ""),
                          ),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          Text(
                            'Shop Size',
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp()),
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
                                  addNewShop.shopSize = int.parse(val.label);
                                },
                                values: shopSize,
                                helperText: "shutter"),
                          ),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          InputTextField(
                              isdigits: true,
                              limit: true,
                              fillColor: Colors.white,
                              title: 'Contact Number',
                              isVisible: true,
                              onChanged: (val) {
                                addNewShop.phone = int.parse(val);
                              }),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          Text(
                            'Road Face',
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp()),
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
                                value: edit
                                    ? editRoadFaceNum
                                    : roadFace[addNewShop.roadFaceNum - 1],
                                onChanged: (val) {
                                  addNewShop.roadFaceNum = int.parse(val.value);

                                  if (int.parse(val.value) == 2) {
                                    ref.read(roadFace2Provider.state).state =
                                        true;
                                    ref.read(roadFace3Provider.state).state =
                                        false;
                                    addNewShop.roadFace.roadFace2 = 1;
                                  } else if (int.parse(val.value) == 3) {
                                    ref.read(roadFace2Provider.state).state =
                                        true;
                                    ref.read(roadFace3Provider.state).state =
                                        true;
                                    addNewShop.roadFace.roadFace2 = 1;
                                    addNewShop.roadFace.roadFace3 = 1;
                                    // print(roadFaceShow);

                                  } else {
                                    // for (int i = 0; i < roadFaceShow.length; i++) {
                                    ref.read(roadFace2Provider.state).state =
                                        false;
                                    ref.read(roadFace3Provider.state).state =
                                        false;

                                    // }
                                  }
                                },
                                values: roadFace,
                                helperText: ""),
                          ),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          Row(
                            children: [
                              DropDownWithText(
                                text: 'Road Face 1',
                                value: edit
                                    ? editRoadFace1
                                    : roadFaceSide[
                                        addNewShop.roadFace.roadFace1],
                                values: roadFaceSide,
                                onChanged: (val) {
                                  addNewShop.roadFace.roadFace1 =
                                      int.parse(val.value);
                                },
                              ),
                              SizedBox(
                                width: !ResponsiveLayout.isMobile
                                    ? 53.sw()
                                    : 15.sw(),
                              ),
                              if (roadFace2Show)
                                DropDownWithText(
                                  text: 'Road Face 2',
                                  value: edit
                                      ? editRoadFace2
                                      : roadFaceSide[
                                          addNewShop.roadFace.roadFace2!],
                                  values: roadFaceSide,
                                  onChanged: (val) {
                                    addNewShop.roadFace.roadFace2 =
                                        int.parse(val.value);
                                  },
                                ),
                              SizedBox(
                                width: !ResponsiveLayout.isMobile
                                    ? 53.sw()
                                    : 15.sw(),
                              ),
                              if (roadFace3Show)
                                DropDownWithText(
                                  text: 'Road Face 3',
                                  value: edit
                                      ? editRoadFace3
                                      : roadFaceSide[
                                          addNewShop.roadFace.roadFace3!],
                                  values: roadFaceSide,
                                  onChanged: (val) {
                                    addNewShop.roadFace.roadFace3 =
                                        int.parse(val.value);
                                  },
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 19.sh(),
                          ),
                          Text(
                            'Marker Colors',
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 16.ssp()),
                          ),
                          SizedBox(
                            height: 19.sh(),
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
                                          borderRadius:
                                              BorderRadius.circular(15.sr()),
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
                                elevatedButtonTextStyle:
                                    kTextStyleInterMedium.copyWith(
                                        fontSize: 20.ssp(),
                                        color: Colors.white),
                                onPressedElevated: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(context, addNewShop);
                                  }
                                  // shop!.color = markerColor;
                                },
                                elevatedButtonText: 'Save'),
                          ),
                          SizedBox(
                            height: 10.sh(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class DropDownWithText extends StatelessWidget {
  const DropDownWithText({
    Key? key,
    required this.text,
    required this.values,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final List<CustomMenuItem> values;
  final CustomMenuItem value;
  final Function(CustomMenuItem) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: kTextStyleIbmSemiBold.copyWith(fontSize: 16.ssp()),
        ),
        SizedBox(
          height: 7.sh(),
        ),
        Container(
          width: 126.sw(),
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
              value: value,
              onChanged: (val) {
                onChanged(val);
              },
              values: values,
              helperText: ""),
        ),
      ],
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
