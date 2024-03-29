import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
   CardContent({
    super.key,
    required this.vlaue,
    required this.mainLable,
    this.lableColor,
    this.valueColor,
  });

  final String mainLable;
  final String vlaue;
  Color? lableColor = Colors.white;
  Color? valueColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          " : $mainLable",
          style: TextStyle(
            color: lableColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          vlaue,
          style: TextStyle(
            color: valueColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
