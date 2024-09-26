import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';

class ClassTile extends StatelessWidget {
  const ClassTile({
    super.key,
    required this.clases,
    required this.index,
  });

  final clases;
  final int index;

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
              " ${clases[index].familyName}",
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
              " ${clases[index].classPrice}",
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
