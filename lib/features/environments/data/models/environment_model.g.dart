// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnvironmentModelAdapter extends TypeAdapter<EnvironmentModel> {
  @override
  final int typeId = 11;

  @override
  EnvironmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnvironmentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String? ?? '',
      initialAmount: fields[3] as double,
      currentBalance: fields[4] as double,
      isClosed: fields[5] as bool? ?? false,
      createdAt: fields[6] as DateTime,
      colorValue: fields[7] as int? ?? 0xFF0B6098,
      iconCodePoint: fields[8] as int? ?? 0xe3ae,
      deductedFromMain: fields[9] as bool? ?? true,
    );
  }

  @override
  void write(BinaryWriter writer, EnvironmentModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.initialAmount)
      ..writeByte(4)
      ..write(obj.currentBalance)
      ..writeByte(5)
      ..write(obj.isClosed)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.colorValue)
      ..writeByte(8)
      ..write(obj.iconCodePoint)
      ..writeByte(9)
      ..write(obj.deductedFromMain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
