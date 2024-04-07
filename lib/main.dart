import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';
import 'package:rae3on_app_new_update/view/pages/navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  await Hive.initFlutter();
  Hive.registerAdapter(TeacherModelAdapter());
  if (!Hive.isBoxOpen('teacher')) await Hive.openBox<TeacherModel>('teacher');
  Hive.registerAdapter(FamilyModelAdapter());
  if (!Hive.isBoxOpen('familes')) await Hive.openBox<FamilyModel>('familes');
  Hive.registerAdapter(ClassModelAdapter());
  if (!Hive.isBoxOpen('clases')) await Hive.openBox<ClassModel>('clases');

  config.get<SharedPreferences>().setString("percent", "10");
  config.get<SharedPreferences>().setString("dinarPrice", "40000");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}
