import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/auth/forgotpassword/forgotpassword.dart';
import 'package:videomanager/screens/auth/login/login.dart';

final AuthStateProvider = StateProvider<bool>((ref) {
  return true;
});

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(AuthStateProvider.state).state;
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
                color: const Color(0xff40667D),
                child: Center(
                  child: SizedBox(
                    height: 700.h,
                    width: 700.w,
                    child: formState ? Login() : ForgotPassword(),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
