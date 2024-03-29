import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/pages/teacher_details.dart';
import 'package:rae3on_app_new_update/view/widgets/my_alert_dialog.dart';
import 'package:rae3on_app_new_update/view/widgets/teacher_tile.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TextEditingController addTeacherController = TextEditingController();

  _addTeacher(BuildContext context) {
    setState(() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          hint: "اسم المدرّس",
          title: "أضف مدرساً",
          controller: addTeacherController,
          onCansle: () {},
          onDone: () {
            final teacher = TeacherModel()..name = addTeacherController.text;
            setState(() {
              final box = DataBase.getTeachers();
              box.add(teacher);

              // teachers.add(TeacherModel(name: addTeacherController.text));
            });
            Navigator.pop(context);
          },
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherDetails(
                              id: index,
                              teacher: teachers[index],
                            )),
                  );
                },
                child: TeacherTile(
                  data: teachers[index],
                ),
              ),
            ),
          );
        },
      )

          //  ListView.builder(
          //   itemCount: teachers.length,
          //   itemBuilder: (context, index) => Container(),
          //   // FadeInLeft(
          //   //   child: TeacherTile(
          //   //       data: TeacherModel(name: teachers[index].name),
          //   //       ),
          //   // ),
          // ),
          ),
    );
  }
}
