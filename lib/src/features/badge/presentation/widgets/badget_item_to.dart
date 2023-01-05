import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/currency_entity.dart';

class BadgeItemTo extends StatefulWidget {
  const BadgeItemTo({
    super.key,
    required this.currencyEntity,
    required this.titulo,
  });

  final CurrencyEntity currencyEntity;
  final String titulo;

  @override
  State<BadgeItemTo> createState() => _BadgeItemToState();
}

class _BadgeItemToState extends State<BadgeItemTo> {
  @override
  Widget build(BuildContext context) {
    final totalFormat = NumberFormat(
        "${widget.currencyEntity.country.currencyAbbrevation}\$ #,##0.00",
        "en_US");

    final badgeBloc = context.watch<BadgeBloc>();
    final toNameCountryAbbr =
        badgeBloc.state.badge.currencyFrom.country.nameCountryAbbrevation;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.titulo,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              totalFormat.format(widget.currencyEntity.amount),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton<CountryEntity>(
              child: Row(
                children: [
                  Flag.fromString(
                    widget.currencyEntity.country.flagCountry,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.currencyEntity.country.nameCountryAbbrevation,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
              onSelected: (value) {
                badgeBloc.add(OnChangeCurrencyToCountry(value));
              },
              itemBuilder: (context) {
                List<PopupMenuItem<CountryEntity>> newCountries = [];

                for (var country in badgeBloc.countries) {
                  if (country.nameCountryAbbrevation != toNameCountryAbbr) {
                    newCountries.add(PopupMenuItem<CountryEntity>(
                      value: country,
                      height: 0,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flag.fromString(
                              country.flagCountry,
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              country.nameCountryAbbrevation,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 37, 37, 37),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
                  }
                }

                return newCountries;
              },
            ),
          ],
        ),
      ],
    );
  }
}
