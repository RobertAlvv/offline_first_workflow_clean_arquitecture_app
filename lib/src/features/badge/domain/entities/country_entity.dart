import 'package:hive_flutter/adapters.dart';

class CountryEntity {
  CountryEntity({
    required this.flagCountry,
    required this.currencyAbbrevation,
    required this.nameCountryAbbrevation,
  });

  final String flagCountry;

  final String currencyAbbrevation;

  final String nameCountryAbbrevation;

  CountryEntity copyWith({
    String? flagCountry,
    String? currencyAbbrevation,
    String? nameCountryAbbrevation,
  }) =>
      CountryEntity(
        flagCountry: flagCountry ?? this.flagCountry,
        currencyAbbrevation: currencyAbbrevation ?? this.currencyAbbrevation,
        nameCountryAbbrevation:
            nameCountryAbbrevation ?? this.nameCountryAbbrevation,
      );
}
