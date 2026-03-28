import 'package:mstech/core/usecase/usecase.dart';
import 'package:mstech/core/utils/typedefs.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';
import 'package:mstech/features/subscription/domain/repository/subscription_repository.dart';

class SetSubscriptionUseCase
    implements UseCaseWithParams<void, SetSubscriptionUseCaseParams> {
  final SubscriptionRepository _repository;

  const SetSubscriptionUseCase({required SubscriptionRepository repository})
    : _repository = repository;

  @override
  ResultVoid call({required SetSubscriptionUseCaseParams params}) async =>
      _repository.setSubscription(subscription: params.subscription);
}

class SetSubscriptionUseCaseParams {
  final Subscription subscription;

  const SetSubscriptionUseCaseParams({required this.subscription});
}
