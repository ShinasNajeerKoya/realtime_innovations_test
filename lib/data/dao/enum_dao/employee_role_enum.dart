import 'package:hive/hive.dart';
import 'package:realtime_innovations_test/config/extensions/string_extension.dart';

enum EmployeeRoleEnumDao { productDesigner, flutterDeveloper, qaTester, productOwner }

class EmployeeRoleEnumDaoAdapter extends TypeAdapter<EmployeeRoleEnumDao> {
  @override
  EmployeeRoleEnumDao read(BinaryReader reader) {
    return EmployeeRoleEnumDao.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, EmployeeRoleEnumDao obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 0;
}

extension EmployeeRoleEnumDaoExtension on EmployeeRoleEnumDao {
  String get value {
    switch (this) {
      case EmployeeRoleEnumDao.productDesigner:
      case EmployeeRoleEnumDao.flutterDeveloper:
      case EmployeeRoleEnumDao.qaTester:
      case EmployeeRoleEnumDao.productOwner:
        return name.toLocalizeString;
    }
  }
}
