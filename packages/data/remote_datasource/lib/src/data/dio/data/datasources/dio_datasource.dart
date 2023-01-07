import 'package:fresh_dio/fresh_dio.dart';

class FailureException implements Exception {}

class DioDatasource {
  static DioDatasource _instance({required String baseUrl}) =>
      DioDatasource._internal(baseUrl: baseUrl);

  DioDatasource._internal({required String baseUrl}) {
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
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(fresh);
  }

  factory DioDatasource({required String baseUrl}) {
    return _instance(baseUrl: baseUrl);
  }

  late Dio _dio;
  late Fresh _fresh;

  Dio get dio => _dio;
  Fresh get fresh => _fresh;

  Stream<AuthenticationStatus> get authenticationStatus =>
      fresh.authenticationStatus;
}
