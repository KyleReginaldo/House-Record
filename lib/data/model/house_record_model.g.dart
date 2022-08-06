// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseRecordModelAdapter extends TypeAdapter<HouseRecordModel> {
  @override
  final int typeId = 5;

  @override
  HouseRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseRecordModel(
      uid: fields[0] as String,
      paymentNumber: fields[1] as String,
      date: fields[2] as String,
      ownerName: fields[3] as String,
      amount: fields[4] as String,
      coveredMonth: fields[5] as String,
      address: fields[6] as String,
      phase: fields[7] as String,
      manager: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HouseRecordModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.paymentNumber)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.ownerName)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.coveredMonth)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.phase)
      ..writeByte(8)
      ..write(obj.manager);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
