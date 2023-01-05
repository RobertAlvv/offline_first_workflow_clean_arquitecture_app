import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeEntity {
  final double amountBase;
  final CurrencyEntity currencyFrom;
  final CurrencyEntity currencyTo;

  BadgeEntity({
    required this.currencyFrom,
    required this.currencyTo,
    required this.amountBase,
  });

  BadgeEntity copyWith({
    CurrencyEntity? currencyFrom,
    CurrencyEntity? currencyTo,
    double? amountBase,
    String? uid,
  }) =>
      BadgeEntity(
        currencyFrom: currencyFrom ?? this.currencyFrom,
        currencyTo: currencyTo ?? this.currencyTo,
        amountBase: amountBase ?? this.amountBase,
      );
}
