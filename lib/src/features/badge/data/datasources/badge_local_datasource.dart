import 'dart:developer';

import 'package:local_datasource/local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/dtos/badge_dto_local.dart';

abstract class IBadgeLocalDataSource {
  Map<int, BadgeDtoLocal?> getAllBadge();
  MapEntry<int, BadgeDtoLocal?>? getBadge({
    required String from,
    required String to,
  });
  Future<dynamic> saveBadge({
    required String from,
    required String to,
    required BadgeDtoLocal badge,
  });
}

class BadgeLocalDataSourceImpl implements IBadgeLocalDataSource {
  final LocalRepository _repository;

  const BadgeLocalDataSourceImpl({required LocalRepository repository})
      : _repository = repository;

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
  Future saveBadge({
    required String from,
    required String to,
    required BadgeDtoLocal badge,
  }) async {
    try {
      final badgeLocal = getBadge(from: from, to: to);

      if (badgeLocal?.value == null) {
        await _addBadge(badge);
      } else {
        await _putBadge(key: badgeLocal!.key, value: badge);
      }
    } catch (e) {
      return throw [];
    }
  }

  Future<dynamic> _addBadge(BadgeDtoLocal badge) async {
    try {
      return await _repository.add("badge", value: badge);
    } catch (e) {
      log(e.toString());
      return throw [];
    }
  }

  Future<void> _putBadge({
    required int key,
    required BadgeDtoLocal value,
  }) async {
    try {
      await _repository.put("badge", key: key, value: value);
    } catch (e) {
      throw [];
    }
  }
}
