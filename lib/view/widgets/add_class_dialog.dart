

// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddClassDialog extends StatefulWidget {
  AddClassDialog({
    super.key,
    required this.familesName,
    required this.teacher,
  });

  final List<FamilyModel> familesName;
  FamilyModel selectedFamily = FamilyModel();
  final TeacherModel teacher;

  @override
  State<AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> with CaculateFunctions {
  TextEditingController controller = TextEditingController();
  final percentAsString = config.get<SharedPreferences>().getString("percent");
  final dinarPriceAsString =
      config.get<SharedPreferences>().getString("dinarPrice");
  final globalKey = config.get<GlobalKey<FormState>>();

  @override
  void initState() {
    super.initState();
    // التأكد من أن القيمة الافتراضية تتواجد ضمن قائمة items
    if (widget.familesName.isNotEmpty) {
      if (widget.selectedFamily.id.isEmpty ||
          !widget.familesName.any((family) => family.id == widget.selectedFamily.id)) {
        widget.selectedFamily = widget.familesName.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "أضف حصة",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.start,
      ),
      content: SizedBox(
        height: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: globalKey,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: "سعر الحصص",
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "إملأ الحقل";
                    }
                    if (value.trim().contains(" ") ||
                        value.trim().contains("_") ||
                        value.trim().contains("-") ||
                        value.trim().contains(",")) {
                      return "يوجد علامات غير مرغوبة";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownButton<String>(
                isExpanded: true,
                alignment: Alignment.center,
                value: widget.selectedFamily.id.isNotEmpty
                    ? widget.selectedFamily.id
                    : null,
                items: widget.familesName.map((family) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.centerRight,
                    value: family.id,
                    child: Text(family.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.selectedFamily.id = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "تراجع",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[600]),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (globalKey.currentState!.validate()) {
                final ClassModel aClass = ClassModel()
                  ..id = const Uuid().v4()
                  ..familyName = widget.selectedFamily.id
                  ..teacherName = widget.teacher.id
                  ..classPrice = num.parse(controller.text);

                if (percentAsString != null || dinarPriceAsString != null) {
                  final teacher = widget.teacher;
                  num percent = num.parse(config.get<SharedPreferences>().getString("percent")!);
                  num dinarPrice = num.parse(config.get<SharedPreferences>().getString("dinarPrice")!);

                  teacher.acountInDinar += num.parse(controller.text);
                  teacher.acountInDinarWithDiscount = clacCoinWithDiscount(
                    coin: teacher.acountInDinar,
                    percent: percent,
                  );
                  teacher.acountInLira = clacAcountInLira(
                      accountInDinar: teacher.acountInDinar,
                      dinarPrice: dinarPrice);
                  teacher.acountInLiraWithDiscount = clacCoinWithDiscount(
                      coin: teacher.acountInLira, percent: percent);
                  widget.teacher.save();
                  final box = DataBase.getClass();
                  box.add(aClass);
                  
                  Navigator.pop(context);
                } else {
                  Flushbar(
                    title: "خطأ",
                    titleColor: Colors.red,
                    message: "حقل النسبة أو سعر الدينار غير ممتلئ",
                    flushbarPosition: FlushbarPosition.TOP,
                    icon: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    textDirection: TextDirection.rtl,
                    duration: const Duration(seconds: 2),
                  ).show(context);
                }
              }
            });
          },
          child: const Text(
            "أضف",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}














//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// // ignore_for_file: must_be_immutable

// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rae3on_app_new_update/core/di.dart';
// import 'package:rae3on_app_new_update/core/functions.dart';
// import 'package:rae3on_app_new_update/model/class_model.dart';
// import 'package:rae3on_app_new_update/model/family_model.dart';
// import 'package:rae3on_app_new_update/model/teacher_model.dart';
// import 'package:rae3on_app_new_update/storage/database.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class AddClassDialog extends StatefulWidget {
//   AddClassDialog({
//     super.key,
//     required this.familesName,
//     // required this.selectedFamily,
//     // required this.onDone,
//     // required this.onCansle,
//     // required this.controller,
//     required this.teacher,
//   });

//   final List<FamilyModel> familesName;
//   FamilyModel selectedFamily = FamilyModel();
//   final TeacherModel teacher;

//   @override
//   State<AddClassDialog> createState() => _AddClassDialogState();
// }

// class _AddClassDialogState extends State<AddClassDialog>
//     with CaculateFunctions {
//   TextEditingController controller = TextEditingController();
//   final percentAsString = config.get<SharedPreferences>().getString("percent");
//   final dinarPriceAsString =
//       config.get<SharedPreferences>().getString("dinarPrice");
//   final globalKey = config.get<GlobalKey<FormState>>();
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text(
//         "أضف حصة",
//         textDirection: TextDirection.rtl,
//         textAlign: TextAlign.start,
//       ),
//       content: SizedBox(
//         height: 150,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Form(
//                 key: globalKey,
//                 child: TextFormField(
//                   controller: controller,
//                   keyboardType: TextInputType.number,
//                   textAlignVertical: TextAlignVertical.center,
//                   textDirection: TextDirection.ltr,
//                   textAlign: TextAlign.end,
//                   decoration: const InputDecoration(
//                     hintText: "سعر الحصص",
//                   ),
//                   validator: (value) {
//                     if (value!.trim().isEmpty) {
//                       return "إملأ الحقل";
//                     }
//                     if (value.trim().contains(" ") ||
//                         value.trim().contains("_") ||
//                         value.trim().contains("-") ||
//                         value.trim().contains(",")) {
//                       return "يوجد علامات غير مرغوبة";
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 alignment: Alignment.center,
//                 value: widget.selectedFamily.id,
//                 items: List.generate(
//                   widget.familesName.length,
//                   (index) => DropdownMenuItem(
//                     alignment: Alignment.centerRight,
//                     value: widget.familesName[index].id,
//                     child: Text(widget.familesName[index].name),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     widget.selectedFamily.id = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             "تراجع",
//             style:
//                 TextStyle(fontWeight: FontWeight.bold, color: Colors.red[600]),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             // print(controller.text);

//             setState(() {
//               if (globalKey.currentState!.validate()) {
//                 final ClassModel aClass = ClassModel()
//                   ..id = const Uuid().v4()
//                   ..familyName = widget.selectedFamily.id
//                   ..teacherName = widget.teacher.id
//                   ..classPrice = num.parse(controller.text);

//                 if (percentAsString != null || dinarPriceAsString != null) {
//                   final teacher = widget.teacher;
//                   num percent = num.parse(
//                       config.get<SharedPreferences>().getString("percent")!);
//                   num dinarPrice = num.parse(
//                       config.get<SharedPreferences>().getString("dinarPrice")!);

//                   teacher.acountInDinar += num.parse(controller.text);
//                   teacher.acountInDinarWithDiscount = clacCoinWithDiscount(
//                     coin: teacher.acountInDinar,
//                     percent: percent,
//                   );
//                   teacher.acountInLira = clacAcountInLira(
//                       accountInDinar: teacher.acountInDinar,
//                       dinarPrice: dinarPrice);
//                   teacher.acountInLiraWithDiscount = clacCoinWithDiscount(
//                       coin: teacher.acountInLira, percent: percent);
//                   widget.teacher.save();
//                   final box = DataBase.getClass();
//                   box.add(aClass);
//                   Navigator.pop(context);
//                 } else {
//                   Flushbar(
//                     title: "خطأ",
//                     titleColor: Colors.red,
//                     message: "حقل النسبة أو سعر الدينار غير ممتلئ",
//                     flushbarPosition: FlushbarPosition.TOP,
//                     icon: const Icon(
//                       Icons.error,
//                       color: Colors.red,
//                     ),
//                     textDirection: TextDirection.rtl,
//                     duration: const Duration(seconds: 2),
//                   ).show(context);
//                 }
//               }
//             });
//           },
//           child: const Text(
//             "أضف",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
