import 'package:remote_datasource/remote_datasource.dart';

abstract class IBadgeDataSource {
  Future<String> getDivisa({required String from, required String to});
}

class BadgeDataSourceImpl implements IBadgeDataSource {
  final DioRepository _repository;

  const BadgeDataSourceImpl({required DioRepository repository})
      : _repository = repository;

  @override
  Future<String> getDivisa({required String from, required String to}) async {
    try {
      final response = await _repository.get(
        '/exchange',
        headers: {
          "X-RapidAPI-Key": "8e8f987914mshbcfcd90080fc6e4p1d6f54jsn770c179cb34f"
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
