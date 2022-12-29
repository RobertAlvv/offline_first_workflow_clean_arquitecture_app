class CurrencyEntity {
  final String name;
  final CountryEntity country;

  CurrencyEntity(this.name, this.country);
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
}
