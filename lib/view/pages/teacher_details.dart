import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/widgets/add_class_dialog.dart';
import 'package:rae3on_app_new_update/view/widgets/card_content.dart';
import 'package:rae3on_app_new_update/view/widgets/class_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key, required this.id, required this.teacher});
  final int id;
  final TeacherModel teacher;

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails>
    with CaculateFunctions {
  //! ============================================================================
  //! ================================== Varibles ================================
  //! ============================================================================

  Color? lableColor = Colors.white;
  Color? valueColor = Colors.white;
  final familes =
      DataBase.getFamiles().values.toList().cast<FamilyModel>().toList();
  String selectedFamily = "اختر العائلة";

  @override
  Widget build(BuildContext context) {
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
              expandedHeight: 310.0,
              flexibleSpace: FlexibleSpaceBar(
                background: ValueListenableBuilder(
                  valueListenable: DataBase.getTeachers().listenable(),
                  builder: (BuildContext context, box, _) {
                    TeacherModel teacher = box.values
                        .cast<TeacherModel>()
                        .firstWhere(
                            (element) => element.id == widget.teacher.id,
                            orElse: () => TeacherModel()
                              ..id = widget.teacher.id
                              ..name = widget.teacher.name
                              ..acountInDinar = 0
                              ..acountInDinarWithDiscount = 0
                              ..acountInLira = 0
                              ..acountInLiraWithDiscount = 0);

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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // textDirection: TextDirection.rtl,
                        children: [
                          CardContent(
                            mainLable: "اسم المدرّس",
                            vlaue: teacher.name,
                            lableColor: lableColor,
                            valueColor: valueColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardContent(
                            mainLable: "الحساب بالدينار",
                            vlaue:
                                "${formatNumber(number: teacher.acountInDinar)}",
                            lableColor: lableColor,
                            valueColor: valueColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardContent(
                            mainLable: "الحساب بالدينار مع حسم",
                            vlaue:
                                "${formatNumber(number: teacher.acountInDinarWithDiscount)}",
                            lableColor: lableColor,
                            valueColor: valueColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardContent(
                            mainLable: "الحساب بالليرة مع حسم",
                            vlaue:
                                "${formatNumber(number: teacher.acountInLiraWithDiscount)}",
                            lableColor: lableColor,
                            valueColor: valueColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardContent(
                            mainLable: "الحساب بالليرة بدون حسم",
                            vlaue:
                                "${formatNumber(number: teacher.acountInLira)}",
                            lableColor: lableColor,
                            valueColor: valueColor,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // textDirection: TextDirection.rtl,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddClassDialog(
                                        teacher: widget.teacher,
                                        familesName: familes,
                                        // selectedFamily: selectedFamily,
                                      );
                                    },
                                  );

                                  // setState(() {});
                                },
                                child: const Text(
                                  "إضافة حصة",
                                  // textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  final clasesBox = DataBase.getClass();
                                  List<ClassModel> allClases = clasesBox.values
                                      .toList()
                                      .cast<ClassModel>();
                                  for (var i = allClases.length - 1;
                                      i >= 0;
                                      i--) {
                                    if (allClases[i].id == widget.teacher.id) {
                                      clasesBox.delete(allClases[i].id);
                                    }
                                  }
                                  // box.delete(teacher.id);
                                  box.deleteAt(widget.id);
                                },
                                child: const Text(
                                  "حذف المدرس",
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
                valueListenable: DataBase.getClass().listenable(),
                builder: (context, box, _) {
                  List<ClassModel> allClases =
                      box.values.cast<ClassModel>().toList();
                  // print(allClases);
                  List<ClassModel> teachersClases = allClases
                      .where(
                          (element) => element.teacherName == widget.teacher.id)
                      .toList();
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
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    final percentAsString = config
                                        .get<SharedPreferences>()
                                        .getString("percent");

                                    final dinarPriceAsString = config
                                        .get<SharedPreferences>()
                                        .getString("dinarPrice");

                                    if (percentAsString != null ||
                                        dinarPriceAsString != null) {
                                      final teacher = widget.teacher;

                                      num percent = num.parse(config
                                          .get<SharedPreferences>()
                                          .getString("percent")!);

                                      num dinarPrice = num.parse(config
                                          .get<SharedPreferences>()
                                          .getString("dinarPrice")!);

                                      teacher.acountInDinar -=
                                          teachersClases[index].classPrice;

                                      teacher.acountInDinarWithDiscount =
                                          clacCoinWithDiscount(
                                        coin: teacher.acountInDinar,
                                        percent: percent,
                                      );

                                      teacher.acountInLira = clacAcountInLira(
                                        accountInDinar: teacher.acountInDinar,
                                        dinarPrice: dinarPrice,
                                      );

                                      teacher.acountInLiraWithDiscount =
                                          clacCoinWithDiscount(
                                        coin: teacher.acountInLira,
                                        percent: percent,
                                      );
                                      widget.teacher.save();
                                    } else {
                                      Flushbar(
                                        title: "خطأ",
                                        titleColor: Colors.red,
                                        message:
                                            "حقل النسبة أو سعر الدينار غير ممتلئ",
                                        flushbarPosition: FlushbarPosition.TOP,
                                        icon: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        // textDirection: TextDirection.rtl,
                                        duration: const Duration(seconds: 2),
                                      ).show(context);
                                    }
                                    box.delete(teachersClases[index].id);
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                )
                              ],
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
                              child: ClassTile(
                                class_: teachersClases[index],
                                // clases: teachersClases,
                                // index: index,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: teachersClases.length,
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
}
