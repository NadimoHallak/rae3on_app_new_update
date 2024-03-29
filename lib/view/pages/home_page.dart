import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/view/widgets/information_card.dart';
import 'package:rae3on_app_new_update/view/widgets/main_home_page_card.dart';
import 'package:rae3on_app_new_update/view/widgets/text_field.dart';
import 'package:rae3on_app_new_update/view/widgets/view_account_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController percentConttroller = TextEditingController();
  TextEditingController dinarPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthPage = MediaQuery.of(context).size.width;
    double heightPage = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الصفحة الرئيسية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      width: widthPage * 0.45,
                      child: MyTextField(
                          controller: percentConttroller,
                          lableText: "النسبة الإدارية"),
                    ),
                  ),
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.only(right: 5, top: 10),
                      width: widthPage * 0.45,
                      child: MyTextField(
                        controller: dinarPriceController,
                        lableText: "سعر الدينار",
                      ),
                    ),
                  ),
                ],
              ),
              FadeInLeft(child: MainHomePageCard(widthPage: widthPage)),
              FadeInRight(child: InformationCard(widthPage: widthPage)),
            ],
          ),
        ),
      ),
    );
  }
}
