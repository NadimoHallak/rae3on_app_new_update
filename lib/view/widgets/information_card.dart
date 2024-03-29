import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
    required this.widthPage,
  });

  final double widthPage;

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            "0  : مجموع الأساتذة الموجودين",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "0  : مجموع العوائل الموجودين",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
