import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/pages/teacher_details.dart';
import 'package:rae3on_app_new_update/view/widgets/my_alert_dialog.dart';
import 'package:rae3on_app_new_update/view/widgets/teacher_tile.dart';
import 'package:uuid/uuid.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TextEditingController addTeacherController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  _addTeacher(BuildContext context) {
    setState(() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => Form(
          key: _key,
          child: MyAlertDialog(
            hint: "اسم المدرّس",
            title: "أضف مدرساً",
            controller: addTeacherController,
            onCansle: () {
              Navigator.pop(context);
            },
            onDone: () async{
              if (_key.currentState!.validate()) {
                final teacher = TeacherModel()
                  // ..id = const Uuid().v4()
                  ..name = addTeacherController.text
                  ..acountInDinar = 0
                  ..acountInDinarWithDiscount = 0
                  ..acountInLira = 0
                  ..acountInLiraWithDiscount = 0;
                final isExist =
                    DataBase.getTeachers().values.cast<TeacherModel>().any(
                          (element) => element.name == teacher.name,
                        );

                if (isExist) {
                  Flushbar(
                    title: "خطأ",
                    titleColor: Colors.red,
                    message: "المدرس موجود مسبقا",
                    flushbarPosition: FlushbarPosition.TOP,
                    icon: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    textDirection: TextDirection.rtl,
                    duration: const Duration(seconds: 2),
                  ).show(context);
                } else {
                  
                    final box = DataBase.getTeachers();
                    final int key = await box.add(teacher);
                    teacher.id = key.toString();
                    teacher.save();
                    print(teacher.id);
                    addTeacherController.clear();
                 
                  Navigator.pop(context);
                }
              }
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "المدرّسين",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _addTeacher(context);
                });
              },
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
        actionsIconTheme: const IconThemeData(size: 35),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Box<TeacherModel>>(
          valueListenable: DataBase.getTeachers().listenable(),
          builder: (context, box, _) {
            final teachers = box.values.toList().cast<TeacherModel>();

            return ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) => FadeInLeft(
                child: InkWell(
                  onTap: () {
                    if (DataBase.getFamiles().isEmpty) {
                      Flushbar(
                        title: "خطأ",
                        titleColor: Colors.red,
                        message: "أضف بعض العائلات",
                        flushbarPosition: FlushbarPosition.TOP,
                        icon: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        textDirection: TextDirection.rtl,
                        duration: const Duration(seconds: 2),
                      ).show(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherDetails(
                            id: index,
                            teacher: teachers[index],
                          ),
                        ),
                      );
                    }
                  },
                  child: TeacherTile(
                    data: teachers[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
