import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/settings/components/customswitch.dart';
import 'package:videomanager/screens/settings/screens/videosettings/components/videoqualityselect.dart';
import 'package:videomanager/screens/settings/screens/videosettings/models/videosetting.dart';
import 'package:videomanager/screens/settings/service/settingService.dart';

class VideoSettings extends ConsumerWidget {
  VideoSettings({required this.videoSetting, Key? key}) : super(key: key);
  final VideoSetting videoSetting;
  late VideoSetting temp = VideoSetting.fromJson(videoSetting.toJson());
  final _formKey = GlobalKey<FormState>();
  late final miniMapValueProvider = StateProvider<bool>((ref) {
    return temp.allowMinMapFScreen;
  });
  late final fullSValueProvider = StateProvider<bool>((ref) {
    return temp.videoFScreen;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniMap = ref.watch(miniMapValueProvider.state).state;
    final fullScreen = ref.watch(fullSValueProvider.state).state;
    final defaultSetting = ref.watch(defaultSettingProvider.state).state;
    return Scaffold(
      appBar: ResponsiveLayout.isMobile ? AppBar() : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 43.sh(),
            left: ResponsiveLayout.isDesktop ? 73.sw() : 20.sw(),
            right: ResponsiveLayout.isDesktop ? 73.sw() : 20.sw(),
          ),
          child: SizedBox(
            width: 816.sw(),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video Settings',
                      style: kTextStyleInterSemiBold.copyWith(
                          fontSize: 21.ssp(), color: primaryColor),
                    ),
                    SizedBox(
                      height: 43.sh(),
                    ),
                    OverflowBar(
                      overflowSpacing: 10.sh(),
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Video Server Url',
                          style: kTextStyleInterRegular.copyWith(
                              fontSize: 16.ssp()),
                        ),

                        // Text(
                        //   'http://  ',
                        //   style: kTextStyleIbmSemiBold.copyWith(
                        //       fontSize: 18.ssp(), color: secondaryColorText),
                        // ),
                        InputTextField(
                            validator: (val) {
                              if (Uri.parse(val!).host.isEmpty) {
                                return 'Enter a valid URL';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              temp.videourl = val;
                            },
                            value: videoSetting.videourl,
                            style: kTextStyleIbmSemiBold.copyWith(
                                fontSize: 18.ssp(), color: Colors.black),
                            title: 'title',
                            isVisible: false),
                      ],
                    ),
                    SizedBox(
                      height: 39.sh(),
                    ),
                    OverflowBar(
                      overflowSpacing: 10.sh(),
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stream Quality',
                          style: kTextStyleInterRegular.copyWith(
                              fontSize: 16.ssp()),
                        ),
                        VideoQualitySelect(
                          value: videoSetting.videoQuality,
                          onChanged: (val) {
                            temp.videoQuality = val;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44.sh(),
                    ),
                    CustomSwitch(
                        text: 'Allow Mini Map In Full Screen',
                        space: 535.sw(),
                        value: miniMap,
                        onChanged: (val) {
                          ref.read(miniMapValueProvider.state).state = val;
                          temp.allowMinMapFScreen = val;
                        }),
                    SizedBox(
                      height: 56.36.sh(),
                    ),
                    CustomSwitch(
                      value: fullScreen,
                      onChanged: (val) {
                        ref.read(fullSValueProvider.state).state = val;
                        temp.videoFScreen = val;
                      },
                      text: 'Video In Full Screen ',
                      space: 603.sw(),
                    ),
                    SizedBox(
                      height: 55.sh(),
                    ),
                    OutlinedElevatedButtonCombo(
                        center: ResponsiveLayout.isMobile ? true : false,
                        outlinedButtonText: 'Reset',
                        elevatedButtonText: 'Apply',
                        onPressedOutlined: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    textSecond: 'reset the following settings?',
                                    elevatedButtonText: 'Yes',
                                    onPressedElevated: () async {
                                      try {
                                        var setting = ref.read(
                                            settingChangeNotifierProvider);

                                        await setting.updateSetting(
                                            videoSetting:
                                                defaultSetting.videoSetting);
                                        snack.success(
                                            'Settings Reset Sucessful');
                                      } catch (e) {
                                        snack.error(e);
                                      }
                                    });
                              });
                        },
                        onPressedElevated: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    elevatedButtonText: 'Yes',
                                    textSecond: 'apply the following settings?',
                                    onPressedElevated: () async {
                                      try {
                                        var setting = ref.read(
                                            settingChangeNotifierProvider);

                                        await setting.updateSetting(
                                            videoSetting: temp);
                                        snack.success(
                                            'Settings Updated Sucessfully');
                                      } catch (e) {
                                        snack.error(e);
                                      }
                                    });
                              });
                        }),
                    // OutlineAndElevatedButton(
                    //   textSecond: 'apply the following settings?',
                    //   reset: true,
                    //   onReset: () {
                    //     var setting = ref.read(settingChangeNotifierProvider);

                    //     setting.updateSetting(
                    //         videoSetting: defaultSetting.videoSetting);
                    //   },
                    //   onApply: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       return true;
                    //     }
                    //     return false;
                    //   },
                    //   onSucess: () {
                    //     var setting = ref.read(settingChangeNotifierProvider);

                    //     setting.updateSetting(videoSetting: temp);
                    //   },
                    // ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
