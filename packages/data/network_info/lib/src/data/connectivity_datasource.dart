import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IConnectivityDatasource {
  Future<ConnectivityResult> get isConnected;
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class ConnectivityDatasourceImpl implements IConnectivityDatasource {
  static final ConnectivityDatasourceImpl _instance =
      ConnectivityDatasourceImpl._internal();

  ConnectivityDatasourceImpl._internal() {
    _connectivity = Connectivity();
  }

  late Connectivity _connectivity;

  Connectivity get connectivity => _connectivity;

  factory ConnectivityDatasourceImpl() {
    return _instance;
  }

  @override
  Future<ConnectivityResult> get isConnected =>
      _connectivity.checkConnectivity();

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
