import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:offline_first_workflow/src/features/checking_internet/domain/usecases/check_internet.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/usecases/on_connectivity_change.dart';

part 'check_internet_event.dart';
part 'check_internet_state.dart';

class CheckInternetBloc extends Bloc<CheckInternetEvent, CheckInternetState> {
  final CheckInternet checkInternet;
  final OnConnectivityChanged onConnectivityChanged;

  CheckInternetBloc(
    this.checkInternet,
    this.onConnectivityChanged,
  ) : super(const CheckInternetState(hasInternet: null)) {
    on<OnCheckInternet>(_onCheckingInternet);
    on<OnStreamCheckInternet>(_onStreamCheckingInternet);

    _init();
  }

  void _init() {
    final resp = onConnectivityChanged();

    resp.fold(
      (error) => add(OnStreamCheckInternet(false)),
      (internetChecker) {
        internetChecker.listen((event) => add(OnStreamCheckInternet(event)));
      },
    );
  }

  void _onCheckingInternet(
    OnCheckInternet event,
    Emitter<CheckInternetState> emit,
  ) async {
    final resp = await checkInternet();

    resp.fold(
      (error) => emit(state.copyWith(hasInternet: false)),
      (hasInternet) => emit(state.copyWith(hasInternet: hasInternet)),
    );
  }

  void _onStreamCheckingInternet(
    OnStreamCheckInternet event,
    Emitter<CheckInternetState> emit,
  ) {
    emit(state.copyWith(hasInternet: event.hasInternet));
  }
}
