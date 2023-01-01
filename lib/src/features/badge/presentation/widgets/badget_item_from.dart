import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/badge_entity.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

class BadgeItemFrom extends StatefulWidget {
  BadgeItemFrom({
    super.key,
    required this.badgeEntity,
    required this.titulo,
  });

  final BadgeEntity badgeEntity;
  final String titulo;

  @override
  State<BadgeItemFrom> createState() => _BadgeItemFromState();
}

class _BadgeItemFromState extends State<BadgeItemFrom> {
  late TextEditingController textEdtController;

  @override
  void initState() {
    super.initState();
    textEdtController =
        TextEditingController(text: widget.badgeEntity.baseAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final totalFormat = NumberFormat("#,##0.00", "en_US");
    final badgeBloc = context.watch<BadgeBloc>();
    final toNameCountryAbbr =
        badgeBloc.state.to.currency.country.nameCountryAbbrevation;

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
                  "${widget.badgeEntity.currency.country.currencyAbbrevation}\$ ",
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
                      final tryParseDouble = double.tryParse(value);
                      num? valueParsed;
                      if (tryParseDouble != null) {
                        valueParsed = totalFormat.parse(value);
                      }
                      badgeBloc.add(OnChangeBaseAmount(valueParsed ?? 0));
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
                  Flag.fromString(
                    widget.badgeEntity.currency.country.flagCountry,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.badgeEntity.currency.country.nameCountryAbbrevation,
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
