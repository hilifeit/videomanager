import 'package:videomanager/screens/auth/auth.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 105.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 98.h,
                  ),
                  Text(
                    'Reset Password',
                    style: kTextStyleIbmMedium.copyWith(
                      fontSize: 25.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    textAlign: TextAlign.center,
                    style: kTextStyleIbmMedium.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 84.h,
            ),
            Column(
              children: [
                Form(
                  key: formKey,
                  child: InputTextField(
                    isVisible: true,
                    title: 'Email',
                    validator: (val) => validateEmail(val!),
                  ),
                ),
                SizedBox(
                  height: 63.5.h,
                ),
                Button(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  label: 'Submit',
                  kLabelTextStyle: kTextStyleIbmMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Consumer(builder: (context, ref, c) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(AuthStateProvider.state).state = true;
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Back To Login',
                          style: kTextStyleIbmRegular,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
