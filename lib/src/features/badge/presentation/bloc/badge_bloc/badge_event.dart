part of 'badge_bloc.dart';

abstract class BadgeEvent {
  const BadgeEvent();
}

class OnChangeBaseAmount extends BadgeEvent {
  final num amount;

  OnChangeBaseAmount(this.amount);
}

class OnGetConvertedCurrency extends BadgeEvent {}

class OnChangeCurrencyFromCountry extends BadgeEvent {
  final CountryEntity country;

  OnChangeCurrencyFromCountry(this.country);
}

class OnChangeCurrencyToCountry extends BadgeEvent {
  final CountryEntity country;

  OnChangeCurrencyToCountry(this.country);
}
