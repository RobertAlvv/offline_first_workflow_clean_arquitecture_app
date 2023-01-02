import 'package:fresh_dio/fresh_dio.dart';

class FailureException implements Exception {}

class DioDatasource {
  static final DioDatasource _instance = DioDatasource._internal();
  DioDatasource._internal() {
    _fresh = Fresh.oAuth2(
      tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
      refreshToken: (token, client) async {
        return OAuth2Token(
          accessToken: token!.accessToken,
          refreshToken: token.refreshToken,
        );
      },
    );

    _dio = Dio();
    _dio.options.baseUrl = "https://currency-exchange.p.rapidapi.com";
    _dio.interceptors.add(fresh);
  }

  factory DioDatasource() {
    return _instance;
  }

  late Dio _dio;
  late Fresh _fresh;

  Dio get dio => _dio;
  Fresh get fresh => _fresh;

  Stream<AuthenticationStatus> get authenticationStatus =>
      fresh.authenticationStatus;
}
