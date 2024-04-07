import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/view/widgets/card_content.dart';

class InformationCard extends StatelessWidget {
  InformationCard({
    super.key,
    required this.widthPage,
    required this.lable1,
    required this.lable2,
    required this.value1,
    required this.value2,
  });

  final double widthPage;
  Color textColor = Colors.white;
  final String lable1;
  final String lable2;
  final String value1;
  final String value2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      width: widthPage,
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
            Color(0xFF935FEC),
            Color.fromARGB(255, 59, 26, 116),
          ],
        ),
        color: const Color.fromARGB(255, 147, 95, 236),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          CardContent(
            vlaue: value1,
            mainLable: lable1,
            lableColor: textColor,
            valueColor: textColor,
          ),
          const SizedBox(
            height: 10,
          ),
          CardContent(
            vlaue: value2,
            mainLable: lable2,
            lableColor: textColor,
            valueColor: textColor,
          ),
        ],
      ),
    );
  }
}
