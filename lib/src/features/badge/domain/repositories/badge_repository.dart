import 'package:dartz/dartz.dart';
import 'package:network_info/network_info.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/dtos/badge_dto_local.dart';

import '../entities/badge_entity.dart';
import '../error/failures.dart';

abstract class IBadgeRepository {
  Future<Either<Failure, BadgeEntity>> getDivisa(BadgeEntity badge);
}

class BadgeRepositoryImpl implements IBadgeRepository {
  final IBadgeRemoteDataSource _remoteSource;
  final IBadgeLocalDataSource _localSource;
  final INetworkInfoRepository _networkInfo;

  const BadgeRepositoryImpl({
    required IBadgeRemoteDataSource remoteSource,
    required IBadgeLocalDataSource localSource,
    required INetworkInfoRepository networkInfo,
  })  : _remoteSource = remoteSource,
        _localSource = localSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, BadgeEntity>> getDivisa(BadgeEntity badge) async {
    final from = badge.currencyFrom.country.currencyAbbrevation;
    final to = badge.currencyTo.country.currencyAbbrevation;

    try {
      final checkConnection = await _networkInfo.checkConnection();

      if (checkConnection) {
        final resp = await _remoteSource.getDivisa(from: from, to: to);

        final badgeNew = badge.copyWith(
          createdAt: () => null,
          amountBase: double.parse(resp),
          currencyTo: badge.currencyTo.copyWith(
            amount: badge.currencyFrom.amount * double.parse(resp),
          ),
        );

        final badgeNewLocal = BadgeDtoLocal.fromModel(badgeNew);

        await _localSource.saveBadge(from: from, to: to, badge: badgeNewLocal);

        return Right(badgeNew);
      } else {
        final badgeLocal = _localSource.getBadge(from: from, to: to);

        if (badgeLocal?.value?.amountBase == null) {
          return Left(CacheFailure());
        }

        final badgeNew = badge.copyWith(
          amountBase: badgeLocal!.value!.amountBase,
          createdAt: () => badgeLocal.value!.createdAt,
          currencyTo: badge.currencyTo.copyWith(
            amount: badge.currencyFrom.amount * badgeLocal.value!.amountBase,
          ),
        );

        return Right(badgeNew);
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
