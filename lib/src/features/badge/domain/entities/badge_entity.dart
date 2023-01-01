import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeEntity {
  final CurrencyEntity currency;
  final double baseAmount;

  BadgeEntity({
    required this.currency,
    required this.baseAmount,
  });

  BadgeEntity copyWith({
    CurrencyEntity? currency,
    double? baseAmount,
  }) =>
      BadgeEntity(
        currency: currency ?? this.currency,
        baseAmount: baseAmount ?? this.baseAmount,
      );
}
