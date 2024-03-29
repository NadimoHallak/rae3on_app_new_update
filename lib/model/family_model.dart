

import 'package:hive/hive.dart';

part 'family_model.g.dart';

@HiveType(typeId: 1)
class FamilyModel extends HiveObject{
  @HiveField(0)
  late String name;
 
}
