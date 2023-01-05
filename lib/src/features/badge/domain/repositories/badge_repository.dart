import 'package:dartz/dartz.dart';
import 'package:network_info/network_info.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/dtos/badge_dto_local.dart';

import '../entities/badge_entity.dart';
import '../error/failures.dart';

abstract class IBadgeRepository {
  Future<Either<Failure, double>> getDivisa({
    required String uuid,
    required BadgeEntity badge,
  });
}

class BadgeRepositoryImpl implements IBadgeRepository {
  final IBadgeRemoteDataSource _remoteData;
  final IBadgeLocalDataSource _localData;
  final INetworkInfoRepository _networkInfo;

  const BadgeRepositoryImpl({
    required IBadgeRemoteDataSource remoteData,
    required IBadgeLocalDataSource localData,
    required INetworkInfoRepository networkInfo,
  })  : _remoteData = remoteData,
        _localData = localData,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, double>> getDivisa({
    required String uuid,
    required BadgeEntity badge,
  }) async {
    final from = badge.currencyFrom.country.currencyAbbrevation;
    final to = badge.currencyTo.country.currencyAbbrevation;

    try {
      final checkConnection = await _networkInfo.checkConnection();

      if (checkConnection) {
        final resp = await _remoteData.getDivisa(from: from, to: to);

        final badgeLocal = _localData.getBadge(from: from, to: to);

        final newBadge = badge.copyWith(amountBase: double.parse(resp));

        if (badgeLocal?.value == null) {
          await _localData.addBadge(badge: BadgeDtoLocal.fromModel(newBadge));
        } else {
          await _localData.putBadge(
            badgeLocal!.key,
            BadgeDtoLocal.fromModel(newBadge),
          );
        }

        return Right(double.parse(resp));
      } else {
        final badge = _localData.getBadge(from: from, to: to);

        if (badge?.value?.amountBase == null) {
          return Left(CacheFailure());
        }
        return Right(badge!.value!.amountBase);
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
