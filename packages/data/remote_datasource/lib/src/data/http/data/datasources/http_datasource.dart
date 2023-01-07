// import 'package:fresh/fresh.dart' as fh;
// import 'package:http/http.dart' as http;

// class FailureException implements Exception {}

class HttpDatasource {
  // static final HttpDatasource _instance = HttpDatasource._internal();
  // HttpDatasource._internal() {
  //   _fresh = Fresh<fh.OAuth2Token>(
  //     tokenStorage: fh.InMemoryTokenStorage<fh.OAuth2Token>(),
  //     refreshToken: (token, client) async {
  //       return fh.OAuth2Token(
  //         accessToken: token!.accessToken,
  //         refreshToken: token.refreshToken,
  //       );
  //     },
  //   );

  //   _http = http.Client();
  //   _http.options.baseUrl = "https://currency-exchange.p.rapidapi.com";
  //   _http.interceptors.add(fresh);
  // }

  // factory HttpDatasource() {
  //   return _instance;
  // }

  // late http.Client _http;
  // late fh.Fresh _fresh;

  // http.Client get httpClient => _http;
  // fh.Fresh get fresh => _fresh;

  // Stream<fh.AuthenticationStatus> get authenticationStatus =>
  //     fresh.authenticationStatus;
}
