import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:videomanager/screens/others/exporter.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key, this.prefixIcon, this.suffixIcon})
      : super(key: key);
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container( 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sr()),
      ),
      child: 
          TextFormField(
            maxLines: 3,
            minLines: 1,
          ),
          
        
      
    );
  }
}
