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
        borderRadius: BorderRadius.circular(12.sr()),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: !ResponsiveLayout.isMobile ? 105.sw() : 25.sw()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 98.sh(),
                  ),
                  Text(
                    'Reset Password',
                    style: kTextStyleIbmMedium.copyWith(
                      fontSize: 25.ssp(),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 17.sh(),
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
              height: 84.sh(),
            ),
            Column(
              children: [
                Form(
                  key: formKey,
                  child: InputTextField(
                    onChanged: (val) {},
                    isVisible: true,
                    title: 'Email',
                    validator: (val) => validateEmail(val!),
                  ),
                ),
                SizedBox(
                  height: 25.5.sh(),
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
                  height: 22.sh(),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Consumer(builder: (context, ref, c) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(authStateProvider.state).state = true;
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
