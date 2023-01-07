import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeEntity {
  final DateTime? createdAt;
  final double amountBase;
  final CurrencyEntity currencyFrom;
  final CurrencyEntity currencyTo;

  BadgeEntity({
    required this.currencyFrom,
    required this.currencyTo,
    required this.amountBase,
    this.createdAt,
  });

  BadgeEntity copyWith({
    CurrencyEntity? currencyFrom,
    CurrencyEntity? currencyTo,
    double? amountBase,
    DateTime? Function()? createdAt,
  }) =>
      BadgeEntity(
        currencyFrom: currencyFrom ?? this.currencyFrom,
        currencyTo: currencyTo ?? this.currencyTo,
        amountBase: amountBase ?? this.amountBase,
        createdAt: createdAt != null ? createdAt() : this.createdAt,
      );
}
