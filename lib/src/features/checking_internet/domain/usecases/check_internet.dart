import 'package:dartz/dartz.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/repositories/check_internet_repository.dart';

class CheckInternet {
  CheckInternet({required ICheckInternetRepository repository})
      : _repository = repository;

  final ICheckInternetRepository _repository;

  Future<Either<dynamic, bool>> call() async {
    return await _repository.checkInternet();
  }
}
