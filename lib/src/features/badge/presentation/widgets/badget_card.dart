import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flag/flag_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:offline_first_workflow/src/features/badge/domain/entities/currency_entity.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      height: size.height * 0.6,
      decoration: const BoxDecoration(
        color: Color(0xFF363535),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(255, 22, 22, 22),
            spreadRadius: 0.5,
            blurRadius: 6,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BadgeItem(
            count: 100000,
            titulo: "Moneda Base",
            currentCountry: CountryEntity(
              flagCountry: "DO",
              currencyAbbrevation: "RD",
              nameCountryAbbrevation: "DOP",
            ),
          ),
          const IconDivider(),
          BadgeItem(
            count: 2000,
            titulo: "Moneda Destino",
            currentCountry: CountryEntity(
              flagCountry: "US",
              currencyAbbrevation: "US",
              nameCountryAbbrevation: "USA",
            ),
          ),
          const SizedBox(height: 30),
          const BadgeBase(),
          const SizedBox(height: 0),
          const ButtonConvert()
        ],
      ),
    );
  }
}

class ButtonConvert extends StatelessWidget {
  const ButtonConvert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'Convertir',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BadgeItem extends StatefulWidget {
  BadgeItem({
    super.key,
    required this.currentCountry,
    required this.titulo,
    required this.count,
  });

  CountryEntity currentCountry;
  final String titulo;
  final double count;

  @override
  State<BadgeItem> createState() => _BadgeItemState();
}

class _BadgeItemState extends State<BadgeItem> {
  final List<CountryEntity> countries = [
    CountryEntity(
      flagCountry: "DO",
      currencyAbbrevation: "RD",
      nameCountryAbbrevation: "DOP",
    ),
    CountryEntity(
      flagCountry: "US",
      currencyAbbrevation: "US",
      nameCountryAbbrevation: "USA",
    ),
    CountryEntity(
      flagCountry: "CA",
      currencyAbbrevation: "CA",
      nameCountryAbbrevation: "CAD",
    ),
    CountryEntity(
      flagCountry: "EU",
      currencyAbbrevation: "EU",
      nameCountryAbbrevation: "EUR",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalFormat = NumberFormat(
        "${widget.currentCountry.currencyAbbrevation}\$ #,##0.00", "en_US");
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
              totalFormat.format(widget.count),
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
                    widget.currentCountry.flagCountry,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.currentCountry.nameCountryAbbrevation,
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
                widget.currentCountry = value;
                setState(() {});
              },
              itemBuilder: (context) {
                return countries
                    .map(
                      (country) => PopupMenuItem<CountryEntity>(
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
                      ),
                    )
                    .toList();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class IconDivider extends StatelessWidget {
  const IconDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          width: size.width * 0.30,
          child: Divider(
            color: Colors.grey.shade500,
            height: 2,
            thickness: 0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Lottie.asset('assets/divisa.json', height: 55),
        ),
        SizedBox(
          height: 20,
          width: size.width * 0.30,
          child: Divider(
            color: Colors.grey.shade500,
            height: 2,
            thickness: 0.8,
          ),
        ),
      ],
    );
  }
}

class BadgeBase extends StatelessWidget {
  const BadgeBase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          '1 DOP = 56.001 USD',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
