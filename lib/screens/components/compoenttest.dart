import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Color _color = Colors.white;

 

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return FocusScope(
      autofocus: true,
      child: DefaultTextStyle(
        style: textTheme.headline4!,
        child: Focus(
          // onKey: _handleKeyPress,
          debugLabel: 'Button',
          child: Builder(
            builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return GestureDetector(
                onTap: () {
                  if (hasFocus) {
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 100,
                    alignment: Alignment.center,
                    color: hasFocus ? _color : Colors.white,
                    child: Text(hasFocus
                        ? "I'm in color! Press R,G,B!"
                        : 'Press to focus'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
