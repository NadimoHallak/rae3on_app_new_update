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
      ..classPrice = fields[0] as num
      ..familyName = fields[1] as String
      ..teacherName = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, ClassModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.classPrice)
      ..writeByte(1)
      ..write(obj.familyName)
      ..writeByte(2)
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
