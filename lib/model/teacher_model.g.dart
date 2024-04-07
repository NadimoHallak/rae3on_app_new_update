// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherModelAdapter extends TypeAdapter<TeacherModel> {
  @override
  final int typeId = 0;

  @override
  TeacherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherModel()
      ..name = fields[0] as String
      ..acountInDinar = fields[1] as num
      ..acountInDinarWithDiscount = fields[2] as num
      ..acountInLira = fields[3] as num
      ..acountInLiraWithDiscount = fields[4] as num;
  }

  @override
  void write(BinaryWriter writer, TeacherModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.acountInDinar)
      ..writeByte(2)
      ..write(obj.acountInDinarWithDiscount)
      ..writeByte(3)
      ..write(obj.acountInLira)
      ..writeByte(4)
      ..write(obj.acountInLiraWithDiscount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
