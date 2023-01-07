import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:remote_datasource/remote_datasource.dart';

abstract class IBadgeRemoteDataSource {
  Future<String> getDivisa({required String from, required String to});
}

class BadgeRemoteDataSourceImpl implements IBadgeRemoteDataSource {
  final RemoteRepository _repository;

  const BadgeRemoteDataSourceImpl({required RemoteRepository repository})
      : _repository = repository;

  @override
  Future<String> getDivisa({required String from, required String to}) async {
    try {
      final response = await _repository.get(
        '/exchange',
        headers: {
          "X-RapidAPI-Key": dotenv.env['X-RapidAPI-Key'],
        },
        queryParameters: {
          "from": from,
          "to": to,
        },
      );

      if (response.statusCode != 200) return throw [];

      return response.data;
    } catch (e) {
      return throw [];
    }
  }
}
