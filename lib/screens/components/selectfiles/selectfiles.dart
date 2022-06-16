import 'package:videomanager/screens/others/exporter.dart';

class SelectFiles extends StatelessWidget {
  const SelectFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1006.sw(),
      height: 188.sh(),
      child: Container(
        color: primaryColor.withOpacity(0.15),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sh()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                backgroundColor:  Color(0xffd9d9d9),
                child: Icon(Videomanager.upload_file,color: primaryColor,),
              ),
              Text(
                'Drag and drop video files to upload',
                style: kTextStyleIbmRegular.copyWith(color: Colors.black),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.sr()))),
                  primary: primaryColor,
                  minimumSize:  Size(103.sw(),28.sh()),
                  maximumSize: Size(103.sw(),28.sh()),
                ),
                
                  onPressed: () {},
                  child: Text(
                    'Select Files',
                    style: kTextStyleInterMedium.copyWith(
                        color: Colors.white, fontSize: 15.ssp()),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
