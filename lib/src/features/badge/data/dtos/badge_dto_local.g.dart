// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_dto_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadgeDtoLocalAdapter extends TypeAdapter<BadgeDtoLocal> {
  @override
  final int typeId = 0;

  @override
  BadgeDtoLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BadgeDtoLocal(
      amountBase: fields[0] as double,
      currencyAbbrevationFrom: fields[1] as String,
      currencyAbbrevationTo: fields[2] as String,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BadgeDtoLocal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amountBase)
      ..writeByte(1)
      ..write(obj.currencyAbbrevationFrom)
      ..writeByte(2)
      ..write(obj.currencyAbbrevationTo)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeDtoLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
