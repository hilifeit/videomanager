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
    value: 0.toString(),
  ),
  CustomMenuItem(
    label: "1",
    value: 1.toString(),
  ),
  CustomMenuItem(
    label: "1.5",
    value: 2.toString(),
  ),
  CustomMenuItem(
    label: "2",
    value: 3.toString(),
  ),
  CustomMenuItem(
    label: "2.5",
    value: 4.toString(),
  ),
];

class MarkerColor {
  MarkerColor({
    required this.color,
  });
  Color color;
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

  // final shopProvider = StateProvider<Shop>((ref) {
  //   return Shop.empty();
  // });
  final roadFace2Provider = StateProvider<bool>((ref) {
    return false;
  });
  final roadFace3Provider = StateProvider<bool>((ref) {
    return false;
  });
  final markercolorProvider = StateProvider<int>((ref) {
    return 0;
  });
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerColor = ref.watch(markercolorProvider.state).state;
    final roadFace2Show = ref.watch(roadFace2Provider.state).state;
    final roadFace3Show = ref.watch(roadFace3Provider.state).state;

    final List<MarkerColor> colors = [
      MarkerColor(
        color: primaryColor,
      ),
      MarkerColor(
        color: Colors.red,
      ),
      MarkerColor(
        color: Colors.amber,
      ),
      MarkerColor(
        color: Colors.blue,
      ),
      MarkerColor(
        color: Color(0xffB5FFF6),
      ),
    ];
    colors.insert(
      0,
      MarkerColor(
        color: shop!.color,
      ),
    );

    // dd = category.firstWhere((element) => element.label == shop!.category);
    if (edit) {
      for (var element in category) {
        if (element.value == shop!.category.toString()) {
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
        if (element.value == shop!.roadFace.roadFace1.toString()) {
          editRoadFace1 = roadFaceSide[roadFaceSide.indexOf(element)];
          break;
        }
      }
      for (var element in roadFaceSide) {
        if (shop!.roadFace.roadFace2 != null) {
          if (element.value == shop!.roadFace.roadFace2.toString()) {
            editRoadFace2 = roadFaceSide[roadFaceSide.indexOf(element)];
            break;
          }
        } else {
          editRoadFace2 = roadFaceSide.first;
        }
      }
      for (var element in roadFaceSide) {
        if (shop!.roadFace.roadFace3 != null) {
          if (element.value == shop!.roadFace.roadFace3.toString()) {
            editRoadFace3 = roadFaceSide[roadFaceSide.indexOf(element)];
            break;
          }
        } else {
          editRoadFace3 = roadFaceSide.first;
        }
      }

      // ref.read(markercolorProvider.state).state = shop!.color;
    }

    // for (var element in colors) {
    //   if (element.color == shop!.color) {
    //     ref.read(markercolorProvider.state).state = colors.indexOf(element);
    //     break;
    //   }
    // }

    return WillPopScope(
      onWillPop: () {
        if (formKey.currentState!.validate()) {
          Navigator.pop(context, shop);
          // return Future.value(true);
        }
        return Future.value(false);
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 845.sh(),
          width: 525.sw(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sr()),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                              value: shop!.shopName,
                              fillColor: Colors.white,
                              title: 'Shop Name',
                              isVisible: true,
                              validator: (val) => validateShop(val!),
                              onChanged: (val) {
                                shop!.shopName = val;
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
                                    shop!.category = int.parse(val.value);
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
                                    shop!.shopSize = int.parse(val.label);
                                  },
                                  values: shopSize,
                                  helperText: "shutter"),
                            ),
                            SizedBox(
                              height: 19.sh(),
                            ),
                            InputTextField(
                                value: shop!.phone == null
                                    ? ""
                                    : shop!.phone.toString(),
                                isdigits: true,
                                limit: true,
                                fillColor: Colors.white,
                                title: 'Contact Number',
                                isVisible: true,
                                onChanged: (val) {
                                  shop!.phone = int.parse(val);
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
                                      : roadFace[shop!.roadFaceNum - 1],
                                  onChanged: (val) {
                                    shop!.roadFaceNum = int.parse(val.value);

                                    if (int.parse(val.value) == 2) {
                                      ref.read(roadFace2Provider.state).state =
                                          true;
                                      ref.read(roadFace3Provider.state).state =
                                          false;
                                      shop!.roadFace.roadFace2 = 1;
                                    } else if (int.parse(val.value) == 3) {
                                      ref.read(roadFace2Provider.state).state =
                                          true;
                                      ref.read(roadFace3Provider.state).state =
                                          true;
                                      shop!.roadFace.roadFace2 = 1;
                                      shop!.roadFace.roadFace3 = 1;
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
                                      : roadFaceSide[shop!.roadFace.roadFace1],
                                  values: roadFaceSide,
                                  onChanged: (val) {
                                    shop!.roadFace.roadFace1 =
                                        int.parse(val.value);
                                  },
                                ),
                                SizedBox(
                                  width: !ResponsiveLayout.isMobile
                                      ? 53.sw()
                                      : 15.sw(),
                                ),
                                if (
                                // roadFace2Show ||
                                shop!.roadFaceNum == 2 ||
                                    shop!.roadFaceNum == 3)
                                  DropDownWithText(
                                    text: 'Road Face 2',
                                    value: edit
                                        ? editRoadFace2
                                        : roadFaceSide[
                                            shop!.roadFace.roadFace2!],
                                    values: roadFaceSide,
                                    onChanged: (val) {
                                      shop!.roadFace.roadFace2 =
                                          int.parse(val.value);
                                    },
                                  ),
                                SizedBox(
                                  width: !ResponsiveLayout.isMobile
                                      ? 53.sw()
                                      : 15.sw(),
                                ),
                                if (
                                // roadFace3Show ||
                                shop!.roadFaceNum == 3)
                                  DropDownWithText(
                                    text: 'Road Face 3',
                                    value: edit
                                        ? editRoadFace3
                                        : roadFaceSide[
                                            shop!.roadFace.roadFace3!],
                                    values: roadFaceSide,
                                    onChanged: (val) {
                                      shop!.roadFace.roadFace3 =
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
                              (index) => markerColor == index
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
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(markercolorProvider.state)
                                              .state = index;
                                          // shop!.color = colors[index].color;
                                        },
                                        child: selectMarkerColor(
                                            colors[index], 15.sr(), ref),
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
                                      Navigator.pop(context, shop);
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
      ),
    );
  }

  Widget selectMarkerColor(MarkerColor item, double radius, WidgetRef ref) {
    return CircleAvatar(
      backgroundColor: item.color,
      radius: radius,
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
