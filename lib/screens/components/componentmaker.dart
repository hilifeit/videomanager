import 'package:videomanager/screens/components/afterfileselection/afterfileselection.dart';
import 'package:videomanager/screens/components/selectfiles/selectfiles.dart';
import 'package:videomanager/screens/others/exporter.dart';

class ComponentMaker extends StatelessWidget {
  const ComponentMaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [SelectFiles(), AfterFileSelection()],
      ),
    );
  }
}
