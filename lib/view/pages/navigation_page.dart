import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/view/pages/family_page.dart';
import 'package:rae3on_app_new_update/view/pages/home_page.dart';
import 'package:rae3on_app_new_update/view/pages/teachers_page.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple,
        backgroundColor: Colors.transparent,
        height: 60,
        index: index,
        onTap: (value) {
          setState(() {
            if (index == 2) {
              Future.delayed(
                Duration(seconds: 2),
              );
            }
            index = value;
          });
        },
        items: const <Widget>[
          Icon(
            Icons.family_restroom,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 25,
          ),
        ],
      ),
      body: [
        FamilyPage(),
        HomePage(),
        TeacherPage(),
      ][index],
    );
  }
}
