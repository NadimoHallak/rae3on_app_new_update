import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/widgets/card_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyDetails extends StatefulWidget {
  const FamilyDetails({super.key, required this.id, required this.family});
  final int id;
  final FamilyModel family;

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> with CaculateFunctions {
  //* ============================================================================
  //* ================================== Varibles ================================
  //* ============================================================================

  Color? lableColor = Colors.white;
  Color? valueColor = Colors.white;
  // final familes = DataBase.getFamiles().values.toList().cast<FamilyModel>();
  // List<String> familesName = [];
  String selectedFamily = "";

  @override
  Widget build(BuildContext context) {
    // familesName = List.generate(
    //   familes.length,
    //   (index) => familes[index].name,
    // );
    // print(familesName);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              stretch: true,
              stretchTriggerOffset: 300.0,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: ValueListenableBuilder(
                  valueListenable: DataBase.getFamiles().listenable(),
                  builder: (BuildContext context, box, _) {
                    FamilyModel family =
                        box.values.cast<FamilyModel>().firstWhere(
                              (element) => element.name == widget.family.name,
                              orElse: () => FamilyModel()
                                ..id = widget.family.id
                                ..name = widget.family.name
                                ..acountInDinar = widget.family.acountInDinar,
                            );
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: <Color>[
                            Color.fromARGB(255, 59, 26, 116),
                            Color(0xFF935FEC),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // textDirection: TextDirection.rtl,
                        children: [
                          Column(
                            children: [
                              CardContent(
                                mainLable: "اسم العائلة",
                                vlaue: family.name,
                                lableColor: lableColor,
                                valueColor: valueColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CardContent(
                                mainLable: "الحساب بالدينار",
                                vlaue:
                                    "${formatNumber(number: family.acountInDinar)}",
                                lableColor: lableColor,
                                valueColor: valueColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // textDirection: TextDirection.rtl,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  final familyBox = DataBase.getFamiles();
                                  if (familyBox
                                      .containsKey(int.parse(family.id))) {
                                    Navigator.pop(context);

                                    final clasesBox = DataBase.getClass();
                                    final teachers = DataBase.getTeachers()
                                        .values
                                        .cast<TeacherModel>()
                                        .toList();

                                    List<ClassModel> allClases = clasesBox
                                        .values
                                        .cast<ClassModel>()
                                        .toList();

                                    for (var i = allClases.length - 1;
                                        i >= 0;
                                        i--) {
                                      if (allClases[i].familyId ==
                                          widget.family.id) {
                                        TeacherModel teacher =
                                            teachers.firstWhere(
                                          (element) =>
                                              element.id ==
                                              allClases[i].teacherId,
                                        );

                                        final percentAsString = config
                                            .get<SharedPreferences>()
                                            .getString("percent");
                                        final dinarPriceAsString = config
                                            .get<SharedPreferences>()
                                            .getString("dinarPrice");

                                        if (percentAsString != null ||
                                            dinarPriceAsString != null) {
                                          num percent = num.parse(config
                                              .get<SharedPreferences>()
                                              .getString("percent")!);
                                          num dinarPrice = num.parse(config
                                              .get<SharedPreferences>()
                                              .getString("dinarPrice")!);

                                          teacher.acountInDinar -=
                                              allClases[i].classPrice;
                                          teacher.acountInDinarWithDiscount =
                                              clacCoinWithDiscount(
                                            coin: teacher.acountInDinar,
                                            percent: percent,
                                          );
                                          teacher.acountInLira =
                                              clacAcountInLira(
                                                  accountInDinar:
                                                      teacher.acountInDinar,
                                                  dinarPrice: dinarPrice);
                                          teacher.acountInLiraWithDiscount =
                                              clacCoinWithDiscount(
                                                  coin: teacher.acountInLira,
                                                  percent: percent);
                                          teacher.save();
                                          clasesBox.delete(
                                              int.parse(allClases[i].id));
                                        }
                                      }
                                    }
                                    familyBox.delete(int.parse(family.id));
                                  } else {
                                    Flushbar(
                                      title: "خطأ",
                                      titleColor: Colors.red,
                                      message: "... يوجد خطأ ما",
                                      flushbarPosition: FlushbarPosition.TOP,
                                      icon: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      // textDirection: TextDirection.rtl,
                                      duration: const Duration(seconds: 2),
                                    ).show(context);
                                  }
                                },
                                child: const Text(
                                  "حذف العائلة",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              sliver: ValueListenableBuilder(
                valueListenable: DataBase.getTeachers().listenable(),
                builder: (context, box, _) {
                  List<ClassModel> allClases =
                      DataBase.getClass().values.cast<ClassModel>().toList();

                  List<ClassModel> familesClases = allClases
                      .where((element) => element.familyId == widget.family.id)
                      .toList();

                  List<TeacherModel> teachers =
                      box.values.cast<TeacherModel>().toList();

                  List<TeacherModel> familesTeachers = [];

                  for (var i = 0; i < familesClases.length; i++) {
                    for (var j = 0; j < teachers.length; j++) {
                      if (familesClases[i].teacherId == teachers[j].id) {
                        familesTeachers.add(TeacherModel()
                          ..id = teachers[j].id
                          ..name = teachers[j].name
                          ..acountInDinar = familesClases[i].classPrice);
                      }
                    }
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                            top: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      color: Colors.black26)
                                ]),
                            child: Column(
                              children: [
                                CardContent(
                                  vlaue: familesTeachers[index].name,
                                  mainLable: "اسم الأستاذ",
                                  lableColor: Colors.deepPurple,
                                  valueColor: Colors.black54,
                                ),
                                CardContent(
                                  vlaue:
                                      "${formatNumber(number: familesTeachers[index].acountInDinar)}",
                                  mainLable: "عدد الدنانير",
                                  lableColor: Colors.deepPurple,
                                  valueColor: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: familesTeachers.length,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  clacDeleteFamily(BuildContext context) {
    Navigator.pop(context);

    final clasesBox = DataBase.getClass();
    final teachers =
        DataBase.getTeachers().values.cast<TeacherModel>().toList();
    List<ClassModel> allClases = clasesBox.values.cast<ClassModel>().toList();
    for (var i = allClases.length - 1; i >= 0; i--) {
      if (allClases[i].familyId == widget.family.name) {
        TeacherModel teacher = teachers.firstWhere(
          (element) => element.name == allClases[i].teacherId,
        );

        final percentAsString =
            config.get<SharedPreferences>().getString("percent");
        final dinarPriceAsString =
            config.get<SharedPreferences>().getString("dinarPrice");

        if (percentAsString != null || dinarPriceAsString != null) {
          num percent =
              num.parse(config.get<SharedPreferences>().getString("percent")!);
          num dinarPrice = num.parse(
              config.get<SharedPreferences>().getString("dinarPrice")!);

          teacher.acountInDinar -= allClases[i].classPrice;
          teacher.acountInDinarWithDiscount = clacCoinWithDiscount(
            coin: teacher.acountInDinar,
            percent: percent,
          );
          teacher.acountInLira = clacAcountInLira(
              accountInDinar: teacher.acountInDinar, dinarPrice: dinarPrice);
          teacher.acountInLiraWithDiscount = clacCoinWithDiscount(
              coin: teacher.acountInLira, percent: percent);
          teacher.save();
          clasesBox.delete(int.parse(allClases[i].id));
        }
      }
    }
  }
}
