part of 'badge_bloc.dart';

class BadgeState extends Equatable {
  const BadgeState({
    required this.from,
    required this.to,
    required this.amountBase,
    this.isLoading = false,
  });

  final BadgeEntity from;
  final BadgeEntity to;
  final double amountBase;
  final bool isLoading;

  BadgeState copyWith({
    BadgeEntity? from,
    BadgeEntity? to,
    double? amountBase,
    bool? isLoading,
  }) =>
      BadgeState(
        from: from ?? this.from,
        to: to ?? this.to,
        amountBase: amountBase ?? this.amountBase,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [from, to, amountBase, isLoading];
}
