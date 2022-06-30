import 'package:videomanager/screens/others/exporter.dart';

class CustomDialogBox {
  CustomDialogBox._();

  static confirm(Function onConfirm) {
    final context = CustomKeys().context!;
    dailog(
        context,
        CustomDialog(
            elevatedButtonText: "Ok",
            onPressedElevated: () {
              onConfirm();
            }));
  }

  static alertMessage(Function onConfirm,
      {required String title, required String message}) {
    final context = CustomKeys().context!;
    dailog(
        context,
        CustomDialog(
          elevatedButtonText: "Ok",
          textFirst: title,
          textSecond: message,
          onCancel: () {
            return Future.value(false);
          },
          onPressedElevated: () {
            onConfirm();
          },
          outlinedButtonText: null,
        ));
  }

  static loading(bool show) {
    final context = CustomKeys().context!;
    final Widget child = Center(
      child: SizedBox(
          width: 20.sr(),
          height: 20.sr(),
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )),
    );
    if (show) {
      dailog(context, child, barrier: false);
    } else {
      Navigator.pop(context);
    }
  }

  static dailog(BuildContext context, Widget widget, {bool barrier = true}) {
    showDialog(
        barrierDismissible: barrier,
        barrierColor: Theme.of(context).primaryColor.withOpacity(0.25),
        context: context,
        builder: (_) {
          return widget;
        });
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key? key,
    this.outlinedButtonText = 'Cancel',
    required this.elevatedButtonText,
    required this.onPressedElevated,
    this.onCancel,
    this.width,
    this.height,
    this.textFirst = 'Are you sure you want to ',
    this.textSecond = '',
  }) : super(key: key);

  final String elevatedButtonText, textFirst, textSecond;
  final String? outlinedButtonText;
  final Function onPressedElevated;
  final Future<bool> Function()? onCancel;
  double? width, height;

  double defaultHeight = 31.4.sh();
  double defaultWidth = 86.02.sh();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () {
          if (onCancel == null) {
            return Future.value(true);
          } else {
            return Future.value(false);
          }
        },
        child: Center(
          child: Container(
            height: 148.sh(),
            width: 434.sw(),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 86.sw(),
                vertical: 27.sh(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textFirst + textSecond,
                    textAlign: TextAlign.center,
                    style: kTextStyleInterRegular.copyWith(
                      fontSize: 16.ssp(),
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (outlinedButtonText != null) ...[
                        CustomOutlinedButton(
                          width: width ?? defaultWidth,
                          height: height ?? defaultHeight,
                          outlinedButtonText: outlinedButtonText!,
                          onPressedOutlined: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 40.98.sw(),
                        ),
                      ],
                      CustomElevatedButton(
                        width: width ?? defaultWidth,
                        height: height ?? defaultHeight,
                        onPressedElevated: () {
                          onPressedElevated();
                          Navigator.pop(context);
                        },
                        elevatedButtonText: elevatedButtonText,
                        elevatedButtonStyle: kTextStyleIbmSemiBold.copyWith(
                          fontSize: 16.ssp(),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
