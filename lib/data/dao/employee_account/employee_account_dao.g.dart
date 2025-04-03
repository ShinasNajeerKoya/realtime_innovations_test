// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_account_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAccountDaoAdapter extends TypeAdapter<EmployeeAccountDao> {
  @override
  final int typeId = 1;

  @override
  EmployeeAccountDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeAccountDao(
      id: fields[0] as int,
      name: fields[1] as String,
      role: fields[2] as EmployeeRoleEnumDao,
      startDate: fields[3] as DateTime,
      lastDate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeAccountDao obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.lastDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAccountDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
