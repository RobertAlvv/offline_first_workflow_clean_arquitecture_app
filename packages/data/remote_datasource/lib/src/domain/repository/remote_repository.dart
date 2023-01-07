import 'dart:async';

import '../../data/dio/dio.dart';

class RemoteRepository {
  static RemoteRepository _instance({
    required DioRepository dioRepository,
  }) =>
      RemoteRepository._(client: dioRepository);

  factory RemoteRepository({required DioRepository package}) =>
      _instance(dioRepository: package);

  RemoteRepository._({required DioRepository client}) : _client = client;

  late DioRepository _client;

  Stream<StatusAuthentication> get authenticationStatus =>
      _client.authenticationStatus;

  Future<String> get token async => await _client.token;

  Future<void> setToken(String? token) async => await _client.setToken(token);

  Future<void> clearToken() async => await _client.clearToken();

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async =>
      await _client.get(
        path,
        queryParameters: queryParameters,
        headers: headers,
      );

  Future post(
    String path, {
    dynamic data,
  }) async =>
      await _client.post(path, data: data);

  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async =>
      await _client.put(path, data: data);

  Future delete(
    String path, {
    Map<String, dynamic>? data,
  }) async =>
      await _client.delete(path, data: data);
}
