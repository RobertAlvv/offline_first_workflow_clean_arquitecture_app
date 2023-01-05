import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_datasource/src/data/hive/data/datasource/hive_datasource.dart';

class HiveConfig {
  final dynamic adaptar;
  final String nameOpenBox;
  final bool box;

  HiveConfig({
    required this.adaptar,
    required this.nameOpenBox,
    required this.box,
  });
}

class HiveRepository {
  final HiveDatasource _datasource;

  HiveRepository({required HiveDatasource datasource})
      : _datasource = datasource;

  Future initialization<E>(List<HiveConfig> values) async {
    await _datasource.hive.initFlutter();

    for (var i = 0; i < values.length; i++) {
      if (!Hive.isAdapterRegistered(i)) {
        Hive.registerAdapter(values[i].adaptar);
      }
      if (values[i].box) {
        await _openBox(values[i].nameOpenBox);
      }
    }
  }

  Future<Box<E>> _openBox<E>(
    String name, {
    HiveCipher? encryptionCipher,
    bool crashRecovery = true,
    String? path,
    Uint8List? bytes,
    String? collection,
    List<int>? encryptionKey,
  }) async {
    return await _datasource.hive.openBox<E>(
      name,
      bytes: bytes,
      crashRecovery: crashRecovery,
      encryptionCipher: encryptionCipher,
      path: path,
      collection: collection,
      encryptionKey: encryptionKey,
    );
  }

  Future<void> put(
    String nameBox, {
    dynamic key,
    dynamic value,
  }) async {
    return await _datasource.hive.box(nameBox).put(key, value);
  }

  Future<int> add(String nameBox, {dynamic value}) async {
    return await _datasource.hive.box(nameBox).add(value);
  }

  Future<int> clear(String nameBox) async {
    return await _datasource.hive.box(nameBox).clear();
  }

  Future<void> close(String nameBox) async {
    return await _datasource.hive.box(nameBox).close();
  }

  Future<void> get(String nameBox, dynamic key, {dynamic defaultValue}) async {
    return await _datasource.hive
        .box(nameBox)
        .get(key, defaultValue: defaultValue);
  }

  Map<dynamic, dynamic> getAll(String nameBox) {
    final box = _datasource.hive.box(nameBox);

    return box.toMap();
  }

  Future<void> delete(String nameBox, {dynamic key}) async {
    return await _datasource.hive.box(nameBox).delete(key);
  }

  Future<void> deleteAll(
    String nameBox, {
    required Iterable<dynamic> keys,
  }) async {
    return await _datasource.hive.box(nameBox).deleteAll(keys);
  }

  Future<Iterable<int>> addAll(
    String nameBox, {
    required Iterable<dynamic> values,
  }) async {
    return await _datasource.hive.box(nameBox).addAll(values);
  }
}
