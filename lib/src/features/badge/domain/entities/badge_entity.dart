import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeEntity {
  final CurrencyEntity from;
  final CurrencyEntity to;
  final double baseAmount;

  BadgeEntity({
    required this.from,
    required this.to,
    required this.baseAmount,
  });
}
