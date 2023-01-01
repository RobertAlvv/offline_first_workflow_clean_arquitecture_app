import 'package:dartz/dartz.dart';

import '../../data/datasources/badge_datasource.dart';

abstract class IBadgeRepository {
  Future<Either<dynamic, double>> getDivisa({
    required String from,
    required String to,
  });
}

class BadgeRepositoryImpl implements IBadgeRepository {
  final IBadgeDataSource _remoteData;

  const BadgeRepositoryImpl({required IBadgeDataSource remoteData})
      : _remoteData = remoteData;

  @override
  Future<Either<dynamic, double>> getDivisa(
      {required String from, required String to}) async {
    try {
      final resp = await _remoteData.getDivisa(from: from, to: to);
      return Right(double.parse(resp));
    } catch (e) {
      return const Left(null);
    }
  }
}
