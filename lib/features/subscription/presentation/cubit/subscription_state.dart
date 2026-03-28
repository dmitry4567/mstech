part of 'subscription_cubit.dart';

class SubscriptionState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<Subscription> subscriptions;
  final Subscription? selectedSubscription;
  final String error;

  const SubscriptionState({
    required this.isLoading,
    required this.isSuccess,
    required this.error,
    required this.subscriptions,
    this.selectedSubscription,
  });

  SubscriptionState.initial()
    : this(isLoading: false, isSuccess: false, subscriptions: [], error: '');

  SubscriptionState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<Subscription>? subscriptions,
    Subscription? selectedSubscription,
    String? error,
  }) {
    return SubscriptionState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      subscriptions: subscriptions ?? this.subscriptions,
      selectedSubscription: selectedSubscription ?? this.selectedSubscription,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, subscriptions, selectedSubscription, error];
}
