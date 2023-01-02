import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class IInternetConnectionCheckerDatasource {
  Future<bool> get hasConnection;
}

class InternetConnectionCheckerDatasourceImpl
    implements IInternetConnectionCheckerDatasource {
  static final InternetConnectionCheckerDatasourceImpl _instance =
      InternetConnectionCheckerDatasourceImpl._internal();

  InternetConnectionCheckerDatasourceImpl._internal() {
    _internetChecker = InternetConnectionChecker();
  }

  factory InternetConnectionCheckerDatasourceImpl() {
    return _instance;
  }

  late InternetConnectionChecker _internetChecker;

  InternetConnectionChecker get internetChecker => _internetChecker;

  @override
  Future<bool> get hasConnection => _internetChecker.hasConnection;
}
