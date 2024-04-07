import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:rae3on_app_new_update/view/widgets/information_card.dart';
import 'package:rae3on_app_new_update/view/widgets/main_home_page_card.dart';
import 'package:rae3on_app_new_update/view/widgets/text_field.dart';
import 'package:rae3on_app_new_update/view/widgets/view_account_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CaculateFunctions {
  TextEditingController percentConttroller = TextEditingController();

  TextEditingController dinarPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthPage = MediaQuery.of(context).size.width;

    var percent = config.get<SharedPreferences>().getString("percent");
    var dinarPrice = config.get<SharedPreferences>().getString("dinarPrice");
    if (percent != null || dinarPrice != null) {
      percentConttroller.text = percent!;
      dinarPriceController.text = dinarPrice!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الصفحة الرئيسية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        width: widthPage * 0.7,
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Form(
            key: config.get<GlobalKey<FormState>>(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInRight(
                  child: SizedBox(
                    width: widthPage * 0.5,
                    child: MyTextField(
                      controller: percentConttroller,
                      lableText: "النسبة الإدارية",
                      percentIcon: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: widthPage * 0.05,
                ),
                FadeInLeft(
                  child: SizedBox(
                    width: widthPage * 0.5,
                    child: MyTextField(
                      controller: dinarPriceController,
                      lableText: "سعر الدينار",
                      percentIcon: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: widthPage * 0.05,
                ),
                FadeInRight(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (config
                            .get<GlobalKey<FormState>>()
                            .currentState!
                            .validate()) {
                          config
                              .get<SharedPreferences>()
                              .setString("percent", percentConttroller.text);
                          config.get<SharedPreferences>().setString(
                              "dinarPrice", dinarPriceController.text);
                          Navigator.pop(context);
                          recalcChangesAccountsForTeacher(
                            newDinarPrice: num.parse(config
                                .get<SharedPreferences>()
                                .getString("dinarPrice")!),
                            newPercent: num.parse(config
                                .get<SharedPreferences>()
                                .getString("percent")!),
                            context: context,
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: const Text(
                      "تغيير",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                FadeInLeft(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        DataBase.getTeachers().clear();
                        DataBase.getFamiles().clear();
                        DataBase.getClass().clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: const Text(
                      "حذف كل الحسابات",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(child: MainHomePageCard(widthPage: widthPage)),
              FadeInLeft(
                child: InformationCard(
                  widthPage: widthPage,
                  lable1: 'النسبة الإدارية الحالية',
                  lable2: 'سعر الدينار الحالي',
                  value1: '$percent %',
                  value2: '${formatNumber(number: num.parse(dinarPrice!))}',
                ),
              ),
              FadeInRight(
                child: InformationCard(
                  widthPage: widthPage,
                  lable1: 'مجموع المدرسين الموجودين',
                  lable2: 'مجموع العوائل الموجودين',
                  value1: '${calcTotalTeachers()}',
                  value2: '${calcTotalFamiles()}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
