import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';
import 'package:offline_first_workflow/src/features/badge/domain/error/failures.dart';
import 'package:offline_first_workflow/src/features/badge/domain/usecases/get_divisa.dart';

import '../../../domain/entities/badge_entity.dart';
import '../../../domain/entities/country_entity.dart';

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
            badge: BadgeEntity(
              amountBase: 0.0,
              currencyFrom: CurrencyEntity(
                amount: 1.00,
                country: CountryEntity(
                  flagCountry: "DO",
                  currencyAbbrevation: "DOP",
                  nameCountryAbbrevation: "RD",
                ),
              ),
              currencyTo: CurrencyEntity(
                amount: 0.00,
                country: CountryEntity(
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
        badge: state.badge.copyWith(
          currencyFrom: state.badge.currencyFrom.copyWith(
            amount: event.amount.toDouble(),
          ),
        ),
      ),
    );
  }

  void _getConvertedCurrency(
    OnGetConvertedCurrency event,
    Emitter<BadgeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final resp = await getDivisa.call(
      badge: state.badge,
      uuid: '',
    );

    resp.fold(
      (error) async {
        log("not converted: ${error.runtimeType.toString()}");

        emit(state.copyWith(typeError: () => error));
      },
      (value) {
        emit(
          state.copyWith(
            badge: state.badge.copyWith(
              amountBase: value,
              currencyTo: state.badge.currencyTo.copyWith(
                amount: state.badge.currencyFrom.amount * value,
              ),
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false, typeError: () => null));
  }

  void _changeCurrencyFromCountry(
    OnChangeCurrencyFromCountry event,
    Emitter<BadgeState> emit,
  ) {
    emit(
      state.copyWith(
        badge: state.badge.copyWith(
          amountBase: 0,
          currencyFrom: state.badge.currencyFrom
              .copyWith(amount: 1, country: event.country),
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
        badge: state.badge.copyWith(
          amountBase: 0,
          currencyTo: state.badge.currencyTo.copyWith(country: event.country),
        ),
      ),
    );
  }
}
