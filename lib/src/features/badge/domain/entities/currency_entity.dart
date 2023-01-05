import 'country_entity.dart';

class CurrencyEntity {
  final double amount;
  final CountryEntity country;

  CurrencyEntity({
    required this.amount,
    required this.country,
  });
  CurrencyEntity copyWith({
    double? amount,
    CountryEntity? country,
  }) =>
      CurrencyEntity(
        amount: amount ?? this.amount,
        country: country ?? this.country,
      );
}
