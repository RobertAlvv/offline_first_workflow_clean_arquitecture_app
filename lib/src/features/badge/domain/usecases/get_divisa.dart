import 'package:dartz/dartz.dart';
import 'package:offline_first_workflow/src/features/badge/domain/repositories/badge_repository.dart';

class GetDivisa {
  const GetDivisa({required IBadgeRepository repository})
      : _repository = repository;

  final IBadgeRepository _repository;

  Future<Either<dynamic, double>> call({
    required String from,
    required String to,
  }) async =>
      await _repository.getDivisa(from: from, to: to);
}
