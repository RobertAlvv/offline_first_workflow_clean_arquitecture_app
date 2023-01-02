import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info/src/data/data.dart';

abstract class INetworkInfoRepository {
  Future<bool> checkConnection();
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
      return _internetConnectionDatasource.hasConnection;
    }
  }
}
