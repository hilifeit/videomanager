import 'package:videomanager/screens/others/exporter.dart';

class MultiSelectWidget extends FormField<List<String>> {
  final List<String> problems;

  MultiSelectWidget({Key? key, required validate, required this.problems})
      : super(
            key: key,
            builder: (state) {
              late List<String> selectedProblems = [];
              return Wrap(
                  spacing: 20.0.w,
                  runSpacing: 20.0.w,
                  children: problems
                      .asMap()
                      .entries
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            if (selectedProblems.contains(e.value)) {
                              // setState(() {
                              //   selectedProblems.remove(e.value);
                              // });

                              state.setValue([]);
                            } else {
                              // setState(() {
                              //   selectedProblems.add(e.value);
                              // });
                              // onChanged(selectedProblems);
                              // validator(selectedProblems);
                            }

                            // setState(() {
                            //   selectedProblems.add(e.value);
                            // });
                            print(selectedProblems);
                          },
                          child: Container(
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: selectedProblems.contains(e.value)
                                      ? primaryColor
                                      : darkGrey),
                              child: Text(
                                e.value,
                                style: selectedProblems.contains(e.value)
                                    ? kTextStyleIbmRegular.copyWith(
                                        fontSize: 16.ssp(), color: Colors.white)
                                    : kTextStyleIbmRegularBlack.copyWith(
                                        fontSize: 16.ssp()),
                              )),
                        ),
                      )
                      .toList());
            });
}

// class WrapProblems extends StatefulWidget {
//   WrapProblems({Key? key, required this.onChanged, required this.validator})
//       : super(key: key);

//   final Function(List<String>) onChanged;
//   final FormFieldValidator<List<String>> validator;
//   @override
//   State<WrapProblems> createState() => _WrapProblemsState();
// }

// class _WrapProblemsState extends State<WrapProblems> {
 
 

//   @override
//   Widget build(BuildContext context) {
//     return 
        
    
//   }
// }
