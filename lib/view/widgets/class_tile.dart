import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/storage/database.dart';

class ClassTile extends StatelessWidget {
  ClassTile({
    super.key,
    required this.class_,
    // required this.clases,
    // required this.index,
  });

  // final clases;
  // final int index;

  final ClassModel class_;

  String findFamilyName({required String familyId}) {
    FamilyModel family = DataBase.getFamiles()
        .values
        .cast<FamilyModel>()
        .toList()
        .firstWhere((element) => element.id == familyId);
    return family.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            const Text(
              "اسم العائلة :",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 17,
              ),
            ),
            Text(
              findFamilyName(familyId: class_.familyId),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            const Text(
              "الدنانير :",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 17,
              ),
            ),
            Text(
              " ${class_.classPrice}",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
