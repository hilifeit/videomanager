
import 'package:videomanager/screens/others/exporter.dart';

class DottedBox extends StatelessWidget {
  const DottedBox({Key? key, 
  // required this.size,
   required this.child
   }) : super(key: key);
  // final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,c) {
        print(c);
        return CustomPaint(
          size:  Size(c.maxWidth,c.maxHeight),
          painter: DottedBoxPainter(),
          child: child,
        );
      }
    );
  }
}

class DottedBoxPainter extends CustomPainter {
  DottedBoxPainter({this.multiplier=1});
  final int multiplier;
  @override
  void paint(Canvas canvas, Size size) {

    double width = size.width;
      int x = (width/5).toInt();
      double remx = (width%5);
      double w ;
      if(remx>5){ w = (x+1)*5;}
      else if(remx==5){ w = width;}
      else { w = x*5;}
      print('width = $width and x = $x and remx = $remx and w= $w');

      double height = size.height;
      int y = (height/5).toInt();
      double remy = (height%5);
      double h ;
      if(remx>5){ h = (y+1)*5;}
      else if(remx==5){ h = height;}
      else { h = y*5;}

    int dash =10*multiplier;
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;


      Paint nopaint = Paint()..color=Colors.white..style=PaintingStyle.stroke..strokeWidth=1;


    Rect rectangle = Rect.fromLTWH(20, 20, w, h);

    canvas.drawRect(rectangle, paint);
    for(int i=1;i<=w/dash;i++){
    canvas.drawLine(Offset(12.5+i*dash, 20), Offset(17.5+i*dash,20), nopaint);
    canvas.drawLine(Offset(12.5+i*dash, h+20), Offset(17.5+i*dash,h+20), nopaint);
    
    }
    for(int i=1;i<=h/dash;i++){
    canvas.drawLine(Offset(20, 12.5+i*dash), Offset(20,17.5+i*dash), nopaint);
    canvas.drawLine(Offset(w+20, 12.5+i*dash), Offset(w+20,17.5+i*dash), nopaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
