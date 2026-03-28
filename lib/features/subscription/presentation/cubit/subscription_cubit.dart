import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';
import 'package:mstech/features/subscription/domain/usecase/set_subscription.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SetSubscriptionUseCase _setSubscriptionUseCase;

  SubscriptionCubit({required SetSubscriptionUseCase setSubscriptionUseCase})
    : _setSubscriptionUseCase = setSubscriptionUseCase,
      super(SubscriptionState.initial());

  void selectSubscription({required Subscription subscription}) {
    emit(state.copyWith(selectedSubscription: subscription));
  }

  Future<void> setSubscription({required Subscription subscription}) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _setSubscriptionUseCase(
      params: SetSubscriptionUseCaseParams(subscription: subscription),
    );

    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error.message));
      },
      (_) {
        emit(state.copyWith(isSuccess: true, isLoading: false));
      },
    );
  }

  Future<void> getSubscription() async {
    emit(state.copyWith(isLoading: true, error: null));

    final List<Subscription> subscriptions = [
      Subscription(id: "uid_1", name: "month"),
      Subscription(id: "uid_2", name: "year"),
    ];

    emit(state.copyWith(subscriptions: subscriptions, isLoading: false));
  }
}
