import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:network_info/network_info.dart';

abstract class ICheckInternetRepository {
  Future<Either<dynamic, bool>> checkInternet();
  Either<dynamic, Stream<bool>> onConnectivityChanged();
}

class CheckInternetRepositoryImpl implements ICheckInternetRepository {
  final INetworkInfoRepository _networkInfo;

  const CheckInternetRepositoryImpl({
    required INetworkInfoRepository networkInfo,
  }) : _networkInfo = networkInfo;

  @override
  Future<Either<dynamic, bool>> checkInternet() async {
    try {
      final checkConnection = await _networkInfo.checkConnection();

      return Right(checkConnection);
    } catch (e) {
      return const Left(false);
    }
  }

  @override
  Either<dynamic, Stream<bool>> onConnectivityChanged() {
    try {
      final checkConnection = _networkInfo.onConnectivityChanged();

      return Right(checkConnection);
    } catch (e) {
      return const Left(false);
    }
  }
}
