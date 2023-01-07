part of 'badge_bloc.dart';

class BadgeState extends Equatable {
  const BadgeState({
    required this.badge,
    this.isLoading = false,
    this.typeError,
  });

  final BadgeEntity badge;
  final Failure? typeError;
  final bool isLoading;

  BadgeState copyWith({
    bool? isLoading,
    Failure? Function()? typeError,
    BadgeEntity? badge,
  }) =>
      BadgeState(
        badge: badge ?? this.badge,
        isLoading: isLoading ?? this.isLoading,
        typeError: typeError != null ? typeError() : this.typeError,
      );

  @override
  List<Object?> get props => [badge, isLoading, typeError];
}
