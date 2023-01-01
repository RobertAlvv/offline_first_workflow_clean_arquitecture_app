class CurrencyEntity {
  final String name;
  final CountryEntity country;

  CurrencyEntity(this.name, this.country);
  CurrencyEntity copyWith({
    String? name,
    CountryEntity? country,
  }) =>
      CurrencyEntity(
        name ?? this.name,
        country ?? this.country,
      );
}

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
