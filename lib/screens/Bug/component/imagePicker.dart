import 'dart:io';

import 'package:videomanager/screens/others/exporter.dart';

class ImagePicker<T> extends FormField<FilePickerResult> {
  final Function(FilePickerResult) onChanged;
  ImagePicker(
      {Key? key,
      required this.onChanged,
      required FormFieldValidator validator,
      bool autovalidate = false})
      : super(
            initialValue: FilePickerResult([]),
            key: key,
            validator: validator,
            autovalidateMode: autovalidate
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            builder: (state) {
              return Consumer(builder: (context, ref, c) {
                final result = ref.watch(imageProvider.state).state;
                return Row(
                  children: [
                    if (state.value!.files.isNotEmpty) ...[
                      Wrap(
                          spacing: 20.sw(),
                          children: result.files.map((e) {
                            File file = File(e.path!);

                            return SizedBox(
                              height: 60.sh(),
                              width: 60.sw(),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: SizedBox(
                                        child: Image.memory(
                                      file.readAsBytesSync(),
                                      fit: BoxFit.fill,
                                      height: 50.sh(),
                                      width: 50.sw(),
                                    )),
                                  ),
                                  Positioned(
                                    right: 0.sw(),
                                    top: 0.sh(),
                                    child: InkWell(
                                      onTap: () {
                                        var index = result.files.indexOf(e);
                                        List<PlatformFile> fileList = [];
                                        fileList.addAll(result.files);
                                        fileList.remove(result.files[index]);
                                        ref.read(imageProvider.state).state =
                                            FilePickerResult(fileList);
                                      },
                                      child: CircleAvatar(
                                        radius: 7.sr(),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Icon(
                                          Icons.close,
                                          color: greyish,
                                          size: 13.sr(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
                      SizedBox(
                        width: 20.sw(),
                      )
                    ],
                    if (result.files.length < 3)
                      InkWell(
                        onTap: () async {
                          var singleResult =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          List<PlatformFile> fileList = [];
                          fileList.addAll(result.files);
                          fileList.add(singleResult!.files.first);
                          ref.read(imageProvider.state).state =
                              FilePickerResult(fileList);
                        },
                        child: Icon(
                          Icons.add,
                          size: 22.sp,
                        ),
                      ),
                  ],
                );
              });
            });
}

final imageProvider = StateProvider<FilePickerResult>((ref) {
  return FilePickerResult([]);
});
