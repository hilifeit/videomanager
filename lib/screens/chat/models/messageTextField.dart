import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageTextField extends StatelessWidget {
  MessageTextField(
      {Key? key,
      this.prefixIcon,
      this.suffixIcon,
      required this.onChanged,
      required this.onSend})
      : super(key: key);
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String) onChanged, onSend;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sr()),
      ),
      child: TextFormField(
        controller: _controller,
        textInputAction: TextInputAction.done,
        onChanged: (val) {
          onChanged(val);
        },
        onFieldSubmitted: (val) {
          _controller.clear();
          if (val.isNotEmpty) onSend(val);
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        maxLines: 3,
        minLines: 1,
      ),
    );
  }
}
