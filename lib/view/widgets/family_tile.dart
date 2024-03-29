import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/view/widgets/card_content.dart';

class FamilyTile extends StatelessWidget {
  const FamilyTile({
    super.key,
    required this.data,
  });

  final FamilyModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black45,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(-2, 3))
          ],
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color.fromARGB(255, 59, 26, 116),
              Color(0xFF935FEC),
            ],
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          CardContent(mainLable: "اسم العائلة", vlaue: data.name),
          const SizedBox(
            height: 10,
          ),
           CardContent(mainLable: "الحساب بالدينار", vlaue: "20"),
          const SizedBox(
            height: 10,
          ),
           CardContent(mainLable: "الحساب بالليرة", vlaue: "1000000"),
        ],
      ),
    );
  }
}
