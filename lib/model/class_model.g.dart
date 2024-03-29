// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassModelAdapter extends TypeAdapter<ClassModel> {
  @override
  final int typeId = 2;

  @override
  ClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassModel()
      ..name = fields[0] as String
      ..classType = fields[1] as String
      ..classPrice = fields[2] as double
      ..familyName = fields[3] as String
      ..teacherName = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ClassModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.classType)
      ..writeByte(2)
      ..write(obj.classPrice)
      ..writeByte(3)
      ..write(obj.familyName)
      ..writeByte(4)
      ..write(obj.teacherName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
