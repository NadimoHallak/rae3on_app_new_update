import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/pages/family_page_details.dart';
import 'package:rae3on_app_new_update/view/widgets/family_tile.dart';
import 'package:rae3on_app_new_update/view/widgets/my_alert_dialog.dart';
import 'package:rae3on_app_new_update/view/widgets/teacher_tile.dart';
import 'package:uuid/uuid.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> with CaculateFunctions {
  TextEditingController addFamilyController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    calcTotalDinarToFamilyTeachers(
        familes: DataBase.getFamiles().values.cast<FamilyModel>().toList());
  }

  _addFamily(BuildContext context) {
    setState(() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => Form(
          key: _key,
          child: MyAlertDialog(
            title: "أضف عائلة",
            hint: "اسم العائلة",
            controller: addFamilyController,
            onCansle: () {
              Navigator.pop(context);
            },
            onDone: () {
              if (_key.currentState!.validate()) {
                final family = FamilyModel()
                  ..id = const Uuid().v4()
                  ..name = addFamilyController.text
                  ..acountInDinar = 0;
                final isExist =
                    DataBase.getFamiles().values.cast<FamilyModel>().any(
                          (element) => element.name == family.name,
                        );

                if (isExist) {
                  Flushbar(
                    title: "خطأ",
                    titleColor: Colors.red,
                    message: "العائلة موجودة مسبقا",
                    flushbarPosition: FlushbarPosition.TOP,
                    icon: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    textDirection: TextDirection.rtl,
                    duration: const Duration(seconds: 2),
                  ).show(context);
                } else {
                  setState(() {
                    final box = DataBase.getFamiles();
                    box.add(family);
                    addFamilyController.clear();
                    // teachers.add(TeacherModel(name: addTeacherController.text));
                  });
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
                  _addFamily(context);
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
            final famlies = box.values.cast<FamilyModel>().toList();
            // calcTotalDinarToFamilyTeachers(familes: famlies);
            return ListView.builder(
                itemCount: famlies.length,
                itemBuilder: (context, index) {
                  return FadeInRight(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FamilyDetails(
                              id: index,
                              family: famlies[index],
                            ),
                          ),
                        );
                      },
                      child: FamilyTile(
                        data: famlies[index],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
