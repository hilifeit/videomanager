import 'package:map/map.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/viewscreen/components/singlePathPainter.dart';
import 'package:videomanager/screens/viewscreen/models/originalLocation.dart';

class SinglePath extends StatelessWidget {
  const SinglePath({Key? key, required this.data, required this.transformer})
      : super(key: key);
  final List<OriginalLocation> data;
  final MapTransformer transformer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: SinglePathPainter(transformer: transformer, data: data),
          ),
        ),
        Builder(builder: (context) {
          final size = 12.sr();
          final offset = transformer
              .fromLatLngToXYCoords(LatLng(data.first.lat, data.first.lng));
          return Positioned(
            left: offset.dx - (size / 2),
            top: offset.dy - (size / 2),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              height: size,
              width: size,
            ),
          );
        })
      ],
    );
  }
}
