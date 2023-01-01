import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';
import 'package:offline_first_workflow/src/features/badge/domain/usecases/get_divisa.dart';

import '../../../domain/entities/badge_entity.dart';

part 'badge_event.dart';
part 'badge_state.dart';

class BadgeBloc extends Bloc<BadgeEvent, BadgeState> {
  final GetDivisa getDivisa;

  final List<CountryEntity> countries = [
    CountryEntity(
      flagCountry: "DO",
      currencyAbbrevation: "DOP",
      nameCountryAbbrevation: "RD",
    ),
    CountryEntity(
      flagCountry: "US",
      currencyAbbrevation: "USD",
      nameCountryAbbrevation: "USA",
    ),
    CountryEntity(
      flagCountry: "CA",
      currencyAbbrevation: "CAD",
      nameCountryAbbrevation: "CAD",
    ),
    CountryEntity(
      flagCountry: "EU",
      currencyAbbrevation: "EUR",
      nameCountryAbbrevation: "EUR",
    ),
  ];

  BadgeBloc(this.getDivisa)
      : super(
          BadgeState(
            amountBase: 0.0,
            from: BadgeEntity(
              baseAmount: 1.00,
              currency: CurrencyEntity(
                "Republic Dominican",
                CountryEntity(
                  flagCountry: "DO",
                  currencyAbbrevation: "DOP",
                  nameCountryAbbrevation: "RD",
                ),
              ),
            ),
            to: BadgeEntity(
              baseAmount: 1.00,
              currency: CurrencyEntity(
                "United Stated",
                CountryEntity(
                  flagCountry: "US",
                  currencyAbbrevation: "USD",
                  nameCountryAbbrevation: "USA",
                ),
              ),
            ),
          ),
        ) {
    on<OnChangeBaseAmount>(_changeBaseAmount);
    on<OnGetConvertedCurrency>(_getConvertedCurrency);
    on<OnChangeCurrencyFromCountry>(_changeCurrencyFromCountry);
    on<OnChangeCurrencyToCountry>(_changeCurrencyToCountry);
  }

  void _changeBaseAmount(
    OnChangeBaseAmount event,
    Emitter<BadgeState> emit,
  ) {
    emit(
      state.copyWith(
        from: state.from.copyWith(baseAmount: event.amount.toDouble()),
      ),
    );
  }

  void _getConvertedCurrency(
    OnGetConvertedCurrency event,
    Emitter<BadgeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final resp = await getDivisa.call(
      from: state.from.currency.country.currencyAbbrevation,
      to: state.to.currency.country.currencyAbbrevation,
    );

    resp.fold((error) => log("not converted: ${error.toString()}"), (value) {
      emit(
        state.copyWith(
          isLoading: false,
          amountBase: value,
          to: state.to.copyWith(baseAmount: state.from.baseAmount * value),
        ),
      );
    });
  }

  void _changeCurrencyFromCountry(
    OnChangeCurrencyFromCountry event,
    Emitter<BadgeState> emit,
  ) {
    emit(
      state.copyWith(
        amountBase: 0,
        from: state.from.copyWith(
          currency: state.from.currency.copyWith(country: event.country),
        ),
      ),
    );
  }

  void _changeCurrencyToCountry(
    OnChangeCurrencyToCountry event,
    Emitter<BadgeState> emit,
  ) {
    emit(
      state.copyWith(
        amountBase: 0,
        to: state.to.copyWith(
          currency: state.to.currency.copyWith(country: event.country),
        ),
      ),
    );
  }
}
