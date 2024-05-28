import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CaculateFunctions {
  static calcDiscount({required num percent, required num coin}) {
    return (coin * percent) / 100;
  }

  clacCoinWithDiscount({required num percent, required num coin}) {
    return coin - calcDiscount(percent: percent, coin: coin);
  }

  clacAcountInLira({required num accountInDinar, required num dinarPrice}) {
    return accountInDinar * dinarPrice;
  }

  calcTotalDianr() {
    List<ClassModel> clases =
        DataBase.getClass().values.cast<ClassModel>().toList();
    num totalDinar = 0;
    for (var aClass in clases) {
      totalDinar += aClass.classPrice;
    }
    return totalDinar;
  }

  calcTotalLira({required num dinarPrice}) {
    return clacAcountInLira(
      accountInDinar: calcTotalDianr(),
      dinarPrice: dinarPrice,
    );
  }

  calcTotalDianrWithDiscount({required num percent}) {
    return clacCoinWithDiscount(
      coin: calcTotalDianr(),
      percent: percent,
    );
  }

  calcTotalLiraWithDiscount({required num percent, required dinarPrice}) {
    return clacCoinWithDiscount(
      percent: percent,
      coin: calcTotalLira(dinarPrice: dinarPrice),
    );
  }

  calcPercentInDinar({required num percent}) {
    return calcDiscount(
      percent: percent,
      coin: calcTotalDianr(),
    );
  }

  calcPercentInLira({required num percent, required dinarPrice}) {
    return calcDiscount(
      percent: percent,
      coin: calcTotalLira(dinarPrice: dinarPrice),
    );
  }

  recalcChangesAccountsForTeacher(
      {required num newPercent,
      required num newDinarPrice,
      required BuildContext context}) {
    List<TeacherModel> teachers =
        DataBase.getTeachers().values.cast<TeacherModel>().toList();
    List<TeacherModel> tempTeachers = [];
    for (TeacherModel teacher in teachers) {
      teacher
        ..acountInDinarWithDiscount = clacCoinWithDiscount(
            coin: teacher.acountInDinar, percent: newPercent)
        ..acountInLira = clacAcountInLira(
            accountInDinar: teacher.acountInDinar, dinarPrice: newDinarPrice)
        ..acountInLiraWithDiscount = clacCoinWithDiscount(
            percent: newPercent, coin: teacher.acountInLira);
      teacher.save();
      tempTeachers.add(teacher);
    }
    Flushbar(
      title: "إشعار",
      titleColor: Colors.green,
      message: "تمت العملية بنجاح",
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.notifications_active_sharp,
        color: Colors.green,
      ),
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  calcTotalTeachers() {
    return DataBase.getTeachers().values.cast<TeacherModel>().toList().length;
  }

  calcTotalFamiles() {
    return DataBase.getFamiles().values.cast<FamilyModel>().toList().length;
  }

  formatNumber({required num number}) {
    return NumberFormat.decimalPattern().format(number);
  }

  calcTotalDinarToFamilyTeachers({required List<FamilyModel> familes}) {
    for (var family in familes) {
      List<ClassModel> clases = DataBase.getClass()
          .values
          .cast<ClassModel>()
          .where((element) => element.familyId == family.name)
          .toList();
      num total = 0;
      for (var i = 0; i < clases.length; i++) {
        total += clases[i].classPrice;
      }
      family.acountInDinar = total;
      family.save();
    }
  }


void CalcDeleteClassOnTeacher(
      {required List<ClassModel> teachersClases,
      required int index,
      required BuildContext context, required TeacherModel teacher}) {
    final percentAsString =
        config.get<SharedPreferences>().getString("percent");

    final dinarPriceAsString =
        config.get<SharedPreferences>().getString("dinarPrice");

    if (percentAsString != null || dinarPriceAsString != null) {
      

      num percent =
          num.parse(config.get<SharedPreferences>().getString("percent")!);

      num dinarPrice =
          num.parse(config.get<SharedPreferences>().getString("dinarPrice")!);

      teacher.acountInDinar -= teachersClases[index].classPrice;

      teacher.acountInDinarWithDiscount = clacCoinWithDiscount(
        coin: teacher.acountInDinar,
        percent: percent,
      );

      teacher.acountInLira = clacAcountInLira(
        accountInDinar: teacher.acountInDinar,
        dinarPrice: dinarPrice,
      );

      teacher.acountInLiraWithDiscount = clacCoinWithDiscount(
        coin: teacher.acountInLira,
        percent: percent,
      );
      teacher.save();
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
        // textDirection: TextDirection.rtl,
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }
}




