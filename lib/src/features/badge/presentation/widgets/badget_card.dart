import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/widgets/badget_item_from.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/widgets/badget_item_to.dart';

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
        children: const [
          BadgesWidget(),
          SizedBox(height: 30),
          BadgeBase(),
          SizedBox(height: 0),
          ButtonConvert()
        ],
      ),
    );
  }
}

class BadgesWidget extends StatelessWidget {
  const BadgesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadgeBloc, BadgeState>(
      builder: (context, state) {
        return Column(
          children: [
            BadgeItemFrom(
              titulo: "Moneda Base",
              badgeEntity: state.from,
            ),
            const IconDivider(),
            BadgeItemTo(
              titulo: "Moneda Destino",
              badgeEntity: state.to,
            ),
          ],
        );
      },
    );
  }
}

class ButtonConvert extends StatelessWidget {
  const ButtonConvert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final badgeBloc = context.watch<BadgeBloc>();
    return InkWell(
      onTap: () {
        badgeBloc.add(OnGetConvertedCurrency());
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.center,
          child: BlocSelector<BadgeBloc, BadgeState, bool>(
            selector: (state) {
              return state.isLoading;
            },
            builder: (context, state) {
              if (state) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: const CircularProgressIndicator(color: Colors.white),
                );
              }
              return const Text(
                'Convertir',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
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
    return BlocBuilder<BadgeBloc, BadgeState>(
      builder: (context, state) {
        final currencyFrom = state.from.currency.country.currencyAbbrevation;
        final currencyTo = state.to.currency.country.currencyAbbrevation;

        if (state.amountBase > 0) {
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
                '1 $currencyFrom = ${state.amountBase.toStringAsFixed(3)} $currencyTo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
