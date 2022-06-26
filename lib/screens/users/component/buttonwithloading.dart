import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/users/component/userService.dart';

class ButtonWithLoading extends ConsumerWidget {
  ButtonWithLoading({Key? key}) : super(key: key);
  final loadingStateProvider = StateProvider<bool>((ref) {
    return false;
  });
  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(loadingStateProvider.state).state;
    return InkWell(
      onTap: loading
          ? null
          : (() async {
              try {
                ref.read(loadingStateProvider.state).state = true;
                await ref.read(userChangeProvider).fetchAll();
                Future.delayed(const Duration(milliseconds: 1000), () {
                  ref.read(loadingStateProvider.state).state = false;
                });
              } catch (e) {
                // print(e);
                snack.error(e);
                ref.read(loadingStateProvider.state).state = false;
              }
            }),
      child: CircleAvatar(
        radius: 18.sr(),
        backgroundColor: Theme.of(context).primaryColor,
        child: loading
            ? SizedBox(
                height: 14.28.sr(),
                width: 14.28.sr(),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ))
            : Icon(
                Videomanager.refresh_1,
                size: 14.28.sr(),
                color: Colors.white,
              ),
      ),
    );
  }
}
