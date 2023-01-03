import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_datasource/src/data/hive/data/datasource/hive_datasource.dart';

class HiveRepository {
  final HiveDatasource _datasource;

  static List<Box> boxes = [];

  HiveRepository({required HiveDatasource datasource})
      : _datasource = datasource;

  Future initialization<E>(List<TypeAdapter> values) async {
    await _datasource.hive.initFlutter();

    for (var i = 0; i < values.length; i++) {
      if (!Hive.isAdapterRegistered(i)) {
        Hive.registerAdapter(values[i]);
        boxes.add(await _openBox(values[i].toString()));
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

  Future<void> put(String nameBox, {dynamic key, dynamic value}) async {
    return await boxes[0].put(key, value);
  }

  Future<int> add(String nameBox, {dynamic value}) async {
    return await boxes[0].add(value);
  }

  Future<int> clear(String nameBox) async {
    return await boxes[0].clear();
  }

  Future<void> close(String nameBox) async {
    return await boxes[0].close();
  }

  Future<void> get(String nameBox, dynamic key, {dynamic defaultValue}) async {
    return await boxes[0].get(key, defaultValue: defaultValue);
  }

  Future<void> delete(String nameBox, {dynamic key}) async {
    return await boxes[0].delete(key);
  }

  Future<void> deleteAll(
    String nameBox, {
    required Iterable<dynamic> keys,
  }) async {
    return await boxes[0].deleteAll(keys);
  }

  Future<Iterable<int>> addAll(
    String nameBox, {
    required Iterable<dynamic> values,
  }) async {
    return await boxes[0].addAll(values);
  }
}
