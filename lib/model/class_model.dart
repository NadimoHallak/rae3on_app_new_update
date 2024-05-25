// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'class_model.g.dart';

@HiveType(typeId: 2)
class ClassModel extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late num classPrice;
  @HiveField(2)
  late String familyName;
  @HiveField(3)
  late String teacherName;
 
  
}
