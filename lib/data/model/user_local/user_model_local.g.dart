// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalAdapter extends TypeAdapter<UserLocal> {
  @override
  final int typeId = 2;

  @override
  UserLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocal(
      name: fields[0] as String,
      phone: fields[1] as String,
      pass: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.pass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
