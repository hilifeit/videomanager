import 'dart:io';

import 'package:videomanager/screens/others/exporter.dart';

class ImagePicker<T> extends FormField<FilePickerResult> {
  final Function(FilePickerResult) onChanged;
  final BuildContext context;
  ImagePicker(
      {required this.context,
      Key? key,
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
              // final result = ref.watch(imageProvider.state).state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (state.value!.files.isNotEmpty) ...[
                        Wrap(
                            spacing: 20.sw(),
                            children: state.value!.files.map((e) {
                              File file = File(e.path!);

                              return SizedBox(
                                height: 80.sh(),
                                width: 80.sw(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: SizedBox(
                                          child: Image.memory(
                                        file.readAsBytesSync(),
                                        fit: BoxFit.fill,
                                        height: 70.sh(),
                                        width: 70.sw(),
                                      )),
                                    ),
                                    Positioned(
                                      right: 0.sw(),
                                      top: 0.sh(),
                                      child: InkWell(
                                        onTap: () {
                                          var index =
                                              state.value!.files.indexOf(e);
                                          List<PlatformFile> fileList = [];
                                          fileList.addAll(state.value!.files);
                                          fileList.remove(
                                              state.value!.files[index]);
                                          var value =
                                              FilePickerResult(fileList);
                                          state.didChange(value);
                                          onChanged(state.value!);
                                        },
                                        child: CircleAvatar(
                                          radius: 7.sr(),
                                          backgroundColor: primaryColor,
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
                      if (state.value!.files.length < 3)
                        InkWell(
                          onTap: () async {
                            var singleResult =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowCompression: true,
                              allowedExtensions: ['jpg', 'png'],
                            );
                            double fileSize = (singleResult!.files.first.size) /
                                (1024 * 1024);
                            print(fileSize);
                            if (fileSize < 5) {
                              List<PlatformFile> fileList = [];
                              fileList.addAll(state.value!.files);
                              fileList.add(singleResult.files.first);
                              var value = FilePickerResult(fileList);
                              state.didChange(value);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Invalid File'),
                                      content: Text(
                                          'File size is too large. File must be smaller than 5MB.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 22.sp,
                          ),
                        ),
                    ],
                  ),
                  if (state.hasError) ...[
                    SizedBox(height: 16.h),
                    Text(
                      state.errorText.toString(),
                      style: TextStyle(color: danger, fontSize: 10.ssp()),
                      // style: kTextStyleIbmMedium.copyWith(color: danger)
                    ),
                  ]
                ],
              );
            });
}

// final imageProvider = StateProvider<FilePickerResult>((ref) {
//   return FilePickerResult([]);
// });
