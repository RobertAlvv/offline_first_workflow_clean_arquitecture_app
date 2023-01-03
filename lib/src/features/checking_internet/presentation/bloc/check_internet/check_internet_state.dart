part of 'check_internet_bloc.dart';

class CheckInternetState extends Equatable {
  const CheckInternetState({this.hasInternet});

  final bool? hasInternet;

  CheckInternetState copyWith({
    bool? hasInternet,
  }) =>
      CheckInternetState(hasInternet: hasInternet ?? this.hasInternet);

  @override
  List<Object?> get props => [hasInternet];
}
