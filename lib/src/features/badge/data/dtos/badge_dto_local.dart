import 'package:hive_flutter/adapters.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/badge_entity.dart';

part 'badge_dto_local.g.dart';

@HiveType(typeId: 0)
class BadgeDtoLocal extends HiveObject {
  @HiveField(0)
  final double amountBase;
  @HiveField(1)
  final String currencyAbbrevationFrom;
  @HiveField(2)
  final String currencyAbbrevationTo;

  BadgeDtoLocal({
    required this.amountBase,
    required this.currencyAbbrevationFrom,
    required this.currencyAbbrevationTo,
  });

  BadgeDtoLocal copyWith({
    double? amountBase,
    String? currencyAbbrevationFrom,
    String? currencyAbbrevationTo,
  }) =>
      BadgeDtoLocal(
        amountBase: amountBase ?? this.amountBase,
        currencyAbbrevationFrom:
            currencyAbbrevationFrom ?? this.currencyAbbrevationFrom,
        currencyAbbrevationTo:
            currencyAbbrevationTo ?? this.currencyAbbrevationTo,
      );

  factory BadgeDtoLocal.fromModel(BadgeEntity badgeEntity) {
    return BadgeDtoLocal(
      amountBase: badgeEntity.amountBase,
      currencyAbbrevationFrom:
          badgeEntity.currencyFrom.country.currencyAbbrevation,
      currencyAbbrevationTo: badgeEntity.currencyTo.country.currencyAbbrevation,
    );
  }

  bool sameFromAndTo(
    String currencyAbbrevationFrom,
    String currencyAbbrevationTo,
  ) {
    final theSameFrom = this.currencyAbbrevationFrom == currencyAbbrevationFrom;
    final theSameTo = this.currencyAbbrevationTo == currencyAbbrevationTo;
    return (theSameTo && theSameFrom);
  }
}
