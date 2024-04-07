// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'teacher_model.g.dart';

@HiveType(typeId: 0)
class TeacherModel extends HiveObject {

  @HiveField(0)
  late String name;
  @HiveField(1)
  late num acountInDinar;
  @HiveField(2)
  late num acountInDinarWithDiscount;
  @HiveField(3)
  late num acountInLira;
  @HiveField(4)
  late num acountInLiraWithDiscount;
  
  

  
}
