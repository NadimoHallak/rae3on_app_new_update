import 'package:hive/hive.dart';
import 'package:rae3on_app_new_update/model/class_model.dart';
import 'package:rae3on_app_new_update/model/family_model.dart';
import 'package:rae3on_app_new_update/model/teacher_model.dart';

class DataBase {
  static Box<TeacherModel> getTeachers() => Hive.box('teacher');
  static Box<FamilyModel> getFamiles() => Hive.box('familes');
  static Box<ClassModel> getClass() => Hive.box('clases');
}
