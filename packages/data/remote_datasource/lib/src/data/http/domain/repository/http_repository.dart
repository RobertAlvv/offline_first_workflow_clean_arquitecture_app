import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:remote_datasource/src/data/dio/data/datasources/dio_datasource.dart';

// enum StatusAuthentication {
//   /// The status before the true [AuthenticationStatus] has been determined.
//   initial,

//   /// The status when the application is not authenticated.
//   unauthenticated,

//   /// The status when the application is authenticated.
//   authenticated
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class HttpRepository {
  static HttpRepository _instance({required DioDatasource package}) =>
      HttpRepository._(client: package);

  factory HttpRepository({required DioDatasource package}) =>
      _instance(package: package);

  HttpRepository._({required DioDatasource client}) : _client = client;

  late DioDatasource _client;

  // Stream<StatusAuthentication> get authenticationStatus {
  //   return _client.fresh.authenticationStatus.map((status) {
  //     switch (status) {
  //       case AuthenticationStatus.authenticated:
  //         return StatusAuthentication.authenticated;
  //       case AuthenticationStatus.unauthenticated:
  //         return StatusAuthentication.unauthenticated;
  //       case AuthenticationStatus.initial:
  //         return StatusAuthentication.initial;
  //     }
  //   });
  // }

  Future<String> get token async {
    final oauth2 = await _client.fresh.token;
    final String accessToken = (oauth2 as OAuth2Token).accessToken;
    return accessToken;
  }

  Future<void> setToken(String? token) async =>
      await _client.fresh.setToken(OAuth2Token(accessToken: token ?? ""));

  Future<void> clearToken() async => await _client.fresh.clearToken();

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _client.dio.get(
        path,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
    } on HttpException catch (e) {
      log(e.message.toString());
      return throw [];
    }
  }

  Future post(String path, {dynamic data}) async {
    try {
      return await _client.dio.postUri(Uri.parse(path), data: data);
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? e.toString());
      return throw [];
    }
  }

  Future put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _client.dio.put(path, data: data);
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? e.toString());
      return throw [];
    }
  }

  Future delete(String path, {Map<String, dynamic>? data}) async {
    try {
      return await _client.dio.delete(path, data: data);
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? e.toString());
      return throw [];
    }
  }
}
