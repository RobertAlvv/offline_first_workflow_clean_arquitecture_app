import 'package:local_datasource/local_datasource.dart';

abstract class IBadgeLocalDataSource {
  Future<double> getDivisa({required String from, required String to});
}

class BadgeLocalDataSourceImpl implements IBadgeLocalDataSource {
  final LocalRepository _repository;

  const BadgeLocalDataSourceImpl({required LocalRepository repository})
      : _repository = repository;

  @override
  Future<double> getDivisa({required String from, required String to}) async {
    try {
      // final response = await _repository.get(
      //   '/exchange',
      //   headers: {
      //     "X-RapidAPI-Key": "8e8f987914mshbcfcd90080fc6e4p1d6f54jsn770c179cb34f"
      //   },
      //   queryParameters: {
      //     "from": from,
      //     "to": to,
      //   },
      // );

      // if (response.statusCode != 200) return throw [];

      // return response.data;
      return 0;
    } catch (e) {
      return throw [];
    }
  }
}
