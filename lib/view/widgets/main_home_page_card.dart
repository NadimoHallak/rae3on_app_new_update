
import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/view/widgets/view_account_widget.dart';

class MainHomePageCard extends StatelessWidget {
  const MainHomePageCard({
    super.key,
    required this.widthPage,
  });

  final double widthPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 13),
      padding:
          const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      width: widthPage,
    
      // height: heightPage * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 5,
          color: Colors.deepPurple,
        ),
      ),
    
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          ViewAccountWidget(
            lable: ": المجموع الكلي بالدينار",
            data: "0",
          ),
          ViewAccountWidget(
            lable: ": المجموع الكلي بالليرة",
            data: "0",
          ),
          ViewAccountWidget(
            lable: ": المجموع مع حسم النسبة بالدينار",
            data: "0",
          ),
          ViewAccountWidget(
            lable: ": المجموع مع حسم النسبة بالليرة",
            data: "0",
          ),
          ViewAccountWidget(
            lable: ": النسبة بالدينار",
            data: "0",
          ),
          ViewAccountWidget(
            lable: ": النسبة بالليرة",
            data: "0",
          ),
        ],
      ),
    );
  }
}


