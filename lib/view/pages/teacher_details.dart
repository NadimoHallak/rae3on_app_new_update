import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/widgets/card_content.dart';
import 'package:rae3on_app_new_update/view/widgets/teacher_tile.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key, required this.id, required this.teacher});
  final int id;
  final TeacherModel teacher;

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  Color? lableColor = Colors.white;
  Color? valueColor = Colors.white;
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
              // backgroundColor: Colors.deepPurple,
              // surfaceTintColor: Colors.deepPurple,
              stretch: true,
              stretchTriggerOffset: 300.0,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      CardContent(
                        mainLable: "اسم المدرّس",
                        vlaue: widget.teacher.name,
                        lableColor: lableColor,
                        valueColor: valueColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardContent(
                        mainLable: "الحساب بالدينار",
                        vlaue: "20",
                        lableColor: lableColor,
                        valueColor: valueColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardContent(
                        mainLable: "الحساب بالليرة مع حسم",
                        vlaue: "1000000",
                        lableColor: lableColor,
                        valueColor: valueColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardContent(
                        mainLable: "الحساب بالليرة بدون حسم",
                        vlaue: "1000000",
                        lableColor: lableColor,
                        valueColor: valueColor,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textDirection: TextDirection.rtl,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) => AlertDialog.adaptive(
                                  title: Text("أضف حصة"),
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        decoration: InputDecoration(
                                          hintText: "اسم المادة",
                                        ),
                                      ),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        decoration: InputDecoration(
                                          hintText: "سعر الحصة",
                                        ),
                                      ),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        decoration: InputDecoration(
                                          hintText: "عدد الحصص",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text("إضافة حصة"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "حذف المدرس",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([])),
          ],
        ),
      ),
    );
  }
}
