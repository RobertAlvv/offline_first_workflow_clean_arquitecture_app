import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/repositories/check_internet_repository.dart';

class OnConnectivityChanged {
  OnConnectivityChanged({required ICheckInternetRepository repository})
      : _repository = repository;

  final ICheckInternetRepository _repository;

  Either<bool, Stream<bool>> call() {
    return _repository.onConnectivityChanged();
  }
}
