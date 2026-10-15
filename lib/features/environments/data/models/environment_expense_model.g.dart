// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnvironmentExpenseModelAdapter
    extends TypeAdapter<EnvironmentExpenseModel> {
  @override
  final int typeId = 12;

  @override
  EnvironmentExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnvironmentExpenseModel(
      id: fields[0] as String,
      environmentId: fields[1] as String,
      title: fields[2] as String,
      amount: fields[3] as double,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EnvironmentExpenseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.environmentId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
