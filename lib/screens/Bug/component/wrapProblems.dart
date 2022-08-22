import 'package:videomanager/screens/others/exporter.dart';

class MultiSelectWidget<T> extends FormField<List<T>> {
  final List<T> problems;

  final Function(List<T>) onChanged;
  MultiSelectWidget(
      {Key? key,
      required this.onChanged,
      required this.problems,
      required FormFieldValidator validator,
      bool autovalidate = false})
      : super(
            key: key,
            validator: validator,
            // autovalidateMode: autovalidate
            //     ? AutovalidateMode.onUserInteraction
            //     : AutovalidateMode.onUserInteraction,
            builder: (state) {
              if (state.value == null) {
                Future.delayed(const Duration(milliseconds: 20), () {
                  state.didChange([]);
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.value != null
                      ? Wrap(
                          spacing: 20.0.w,
                          runSpacing: 20.0.w,
                          children: problems
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    if (state.value!.contains(e)) {
                                      var value = state.value;
                                      value!.remove(e);
                                      state.didChange(value);
                                    } else {
                                      var value = state.value;
                                      value!.add(e);
                                      state.didChange(value);
                                    }
                                    onChanged(state.value!);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: state.value!.contains(e)
                                              ? primaryColor
                                              : darkGrey),
                                      child: Text(
                                        e.toString(),
                                        style: state.value!.contains(e)
                                            ? kTextStyleIbmRegular.copyWith(
                                                fontSize: 16.ssp(),
                                                color: Colors.white)
                                            : kTextStyleIbmRegularBlack
                                                .copyWith(fontSize: 16.ssp()),
                                      )),
                                ),
                              )
                              .toList())
                      : Container(),
                  if (state.hasError) ...[
                    SizedBox(height: 20.h),
                    Text(
                      state.errorText.toString(),
                      style: const TextStyle(color: danger, fontSize: 12),
                      // style: kTextStyleIbmMedium.copyWith(color: danger)
                    ),
                  ]
                ],
              );
            });
}
