import 'package:dartz/dartz.dart';
import 'package:network_info/network_info.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_remote_datasource.dart';

abstract class IBadgeRepository {
  Future<Either<dynamic, double>> getDivisa({
    required String from,
    required String to,
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
  Future<Either<dynamic, double>> getDivisa(
      {required String from, required String to}) async {
    try {
      final checkConnection = await _networkInfo.checkConnection();

      if (checkConnection) {
        final resp = await _remoteData.getDivisa(from: from, to: to);
        return Right(double.parse(resp));
      } else {
        final resp = await _localData.getDivisa(from: from, to: to);
        return Right(resp);
      }
    } catch (e) {
      return const Left(null);
    }
  }
}
