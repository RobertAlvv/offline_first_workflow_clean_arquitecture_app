import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info/src/data/data.dart';

abstract class INetworkInfoRepository {
  Future<bool> checkConnection();
  Stream<bool> onConnectivityChanged();
}

class NetworkInfoRepositoryImpl implements INetworkInfoRepository {
  final IConnectivityDatasource _connectivityDatasource;
  final IInternetConnectionCheckerDatasource _internetConnectionDatasource;

  NetworkInfoRepositoryImpl()
      : _connectivityDatasource = ConnectivityDatasourceImpl(),
        _internetConnectionDatasource =
            InternetConnectionCheckerDatasourceImpl();

  @override
  Future<bool> checkConnection() async {
    final event = await _connectivityDatasource.isConnected;
    if (event == ConnectivityResult.none) {
      return false;
    } else {
      return await _internetConnectionDatasource.hasConnection;
    }
  }

  @override
  Stream<bool> onConnectivityChanged() {
    StreamController<bool> newValue = StreamController<bool>.broadcast();

    _connectivityDatasource.onConnectivityChanged.listen((event) async {
      final hasConnection = await _internetConnectionDatasource.hasConnection;

      newValue.add(event != ConnectivityResult.none && hasConnection);
    });

    return newValue.stream;
  }
}
