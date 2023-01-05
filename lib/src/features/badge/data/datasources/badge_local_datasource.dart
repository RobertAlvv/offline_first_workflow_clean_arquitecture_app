import 'dart:developer';

import 'package:local_datasource/local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/dtos/badge_dto_local.dart';

abstract class IBadgeLocalDataSource {
  MapEntry<int, BadgeDtoLocal?>? getBadge({
    required String from,
    required String to,
  });
  Map<int, BadgeDtoLocal?> getAllBadge();
  Future<dynamic> addBadge({required BadgeDtoLocal badge});
  Future<void> putBadge(int key, BadgeDtoLocal value);
}

class BadgeLocalDataSourceImpl implements IBadgeLocalDataSource {
  final LocalRepository _repository;

  const BadgeLocalDataSourceImpl({required LocalRepository repository})
      : _repository = repository;

  @override
  MapEntry<int, BadgeDtoLocal?>? getBadge({
    required String from,
    required String to,
  }) {
    try {
      final Map<int, BadgeDtoLocal?> allBadge = getAllBadge();

      MapEntry<int, BadgeDtoLocal?>? resp;

      allBadge.forEach((key, value) {
        final same = value?.sameFromAndTo(from, to);

        if (same ?? false) {
          resp = MapEntry(key, value);
        }
      });

      return resp;
    } catch (e) {
      return throw [];
    }
  }

  @override
  Future<dynamic> addBadge({required BadgeDtoLocal badge}) async {
    try {
      return await _repository.add("badge", value: badge);
    } catch (e) {
      log(e.toString());
      return throw [];
    }
  }

  @override
  Map<int, BadgeDtoLocal?> getAllBadge() {
    try {
      final resp = _repository.getAll("badge");
      Map<int, BadgeDtoLocal?> respvalue = {};
      resp.forEach((key, value) {
        respvalue.putIfAbsent(key, () => value);
      });

      return respvalue;
    } catch (e) {
      return throw [];
    }
  }

  @override
  Future<void> putBadge(int key, BadgeDtoLocal value) async {
    try {
      await _repository.put("badge", key: key, value: value);
    } catch (e) {
      throw [];
    }
  }
}
