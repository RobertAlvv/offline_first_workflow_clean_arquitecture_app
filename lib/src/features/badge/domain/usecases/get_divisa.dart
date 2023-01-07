import 'package:dartz/dartz.dart';
import 'package:offline_first_workflow/src/features/badge/domain/repositories/badge_repository.dart';

import '../entities/badge_entity.dart';

class GetDivisa {
  const GetDivisa({required IBadgeRepository repository})
      : _repository = repository;

  final IBadgeRepository _repository;

  Future<Either<dynamic, BadgeEntity>> call(BadgeEntity badge) async =>
      await _repository.getDivisa(badge);
}
