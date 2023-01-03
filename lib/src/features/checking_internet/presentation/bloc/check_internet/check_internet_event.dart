part of 'check_internet_bloc.dart';

abstract class CheckInternetEvent {
  const CheckInternetEvent();
}

class OnCheckInternet extends CheckInternetEvent {}

class OnStreamCheckInternet extends CheckInternetEvent {
  final bool hasInternet;

  OnStreamCheckInternet(this.hasInternet);
}
