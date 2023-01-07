import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/currency_entity.dart';

class BadgeItemFrom extends StatefulWidget {
  const BadgeItemFrom({
    super.key,
    required this.currencyEntity,
    required this.titulo,
  });

  final CurrencyEntity currencyEntity;
  final String titulo;

  @override
  State<BadgeItemFrom> createState() => _BadgeItemFromState();
}

class _BadgeItemFromState extends State<BadgeItemFrom> {
  late NumberFormat totalFormat;
  late MoneyMaskedTextController textEdtController;

  @override
  void initState() {
    super.initState();
    totalFormat = NumberFormat("#,##0.00", "en_US");
    textEdtController = MoneyMaskedTextController(
      precision: 2,
      decimalSeparator: '.',
      thousandSeparator: ',',
      initialValue:
          totalFormat.parse(widget.currencyEntity.amount.toString()).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badgeBloc = context.watch<BadgeBloc>();
    final toNameCountryAbbr =
        badgeBloc.state.badge.currencyTo.country.nameCountryAbbrevation;

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${widget.currencyEntity.country.currencyAbbrevation}\$ ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 41,
                  child: TextField(
                    controller: textEdtController,
                    onChanged: (value) {
                      final tryParseDouble =
                          double.tryParse(value.replaceAll(',', ''));

                      if (tryParseDouble == null || tryParseDouble == 0) {
                        value = "1.00";
                        textEdtController.text = value;
                      }

                      final valueFormatted = totalFormat.parse(value);

                      badgeBloc.add(OnChangeBaseAmount(valueFormatted));
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                    keyboardType: TextInputType.number,
                    scrollPadding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 4),
                    ),
                  ),
                ),
              ],
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
                  const SizedBox(width: 10),
                  Flag.fromString(
                    widget.currencyEntity.country.flagCountry,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              onSelected: (value) {
                textEdtController.text = "1.00";
                badgeBloc.add(OnChangeCurrencyFromCountry(value));
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
