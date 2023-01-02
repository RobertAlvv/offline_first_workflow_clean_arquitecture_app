import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeEntity {
  final CurrencyEntity currency;
  final double amount;

  BadgeEntity({
    required this.currency,
    required this.amount,
  });

  BadgeEntity copyWith({
    CurrencyEntity? currency,
    double? amount,
  }) =>
      BadgeEntity(
        currency: currency ?? this.currency,
        amount: amount ?? this.amount,
      );
}
