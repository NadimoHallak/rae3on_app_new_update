// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'teacher_model.g.dart';

@HiveType(typeId: 0)
class TeacherModel extends HiveObject {

  @HiveField(0)
  late String name;
  
  

  
}
