import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/widgets/family_tile.dart';
import 'package:rae3on_app_new_update/view/widgets/my_alert_dialog.dart';
import 'package:rae3on_app_new_update/view/widgets/teacher_tile.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  TextEditingController addFamilyController = TextEditingController();

  _addTeacher(BuildContext context) {
    setState(() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: "أضف عائلة",
          hint: "اسم العائلة",
          controller: addFamilyController,
          onCansle: () {},
          onDone: () {
            final family = FamilyModel()..name = addFamilyController.text;
            setState(() {
              final box = DataBase.getFamiles();
              box.add(family);

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
          "العائلات",
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
          child: ValueListenableBuilder<Box<FamilyModel>>(
        valueListenable: DataBase.getFamiles().listenable(),
        builder: (context, box, _) {
          final famlies = box.values.toList().cast<FamilyModel>();
          return ListView.builder(
            itemCount: famlies.length,
            itemBuilder: (context, index) => FadeInRight(
                child: FamilyTile(
              data: famlies[index],
            )),
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
