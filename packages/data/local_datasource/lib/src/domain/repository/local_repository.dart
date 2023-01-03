import 'package:hive_flutter/adapters.dart';

import '../../../local_datasource.dart';

class LocalRepository {
  static LocalRepository _instance({
    required HiveRepository hiveRepository,
  }) =>
      LocalRepository._(hiveRepository: hiveRepository);

  factory LocalRepository({
    required HiveRepository package,
    required List<TypeAdapter> objects,
  }) {
    final instance = _instance(hiveRepository: package);

    instance.initialization(objects);
    return instance;
  }

  LocalRepository._({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;
  late HiveRepository _hiveRepository;

  Future initialization(
    List<TypeAdapter<dynamic>> values,
  ) async =>
      await _hiveRepository.initialization(values);

  Future get(
    String nameBox,
    dynamic key, {
    dynamic defaultValue,
  }) async =>
      await _hiveRepository.get(
        nameBox,
        key,
        defaultValue: defaultValue,
      );

  Future add(
    String nameBox, {
    dynamic value,
  }) async =>
      await _hiveRepository.add(nameBox, value: value);

  Future put(
    String nameBox, {
    dynamic key,
    dynamic value,
  }) async =>
      await _hiveRepository.put(nameBox, key: key, value: value);

  Future delete(
    String nameBox, {
    dynamic key,
  }) async =>
      await _hiveRepository.delete(nameBox, key: key);

  Future addAll(
    String nameBox, {
    required Iterable<dynamic> values,
  }) async =>
      await _hiveRepository.addAll(nameBox, values: values);

  Future clear(String nameBox) async => await _hiveRepository.clear(nameBox);

  Future close(String nameBox) async => await _hiveRepository.close(nameBox);

  Future deleteAll(
    String nameBox, {
    required Iterable<dynamic> keys,
  }) async =>
      await _hiveRepository.deleteAll(nameBox, keys: keys);
}
