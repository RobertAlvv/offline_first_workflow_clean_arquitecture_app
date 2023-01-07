import 'package:hive_flutter/hive_flutter.dart';

class HiveDatasource {
  static final HiveDatasource _instance = HiveDatasource._internal();

  HiveDatasource._internal();

  factory HiveDatasource() {
    return _instance;
  }

  HiveInterface get hive => Hive;
}
