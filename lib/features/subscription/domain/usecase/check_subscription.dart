import 'package:mstech/core/usecase/usecase.dart';
import 'package:mstech/core/utils/typedefs.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';
import 'package:mstech/features/subscription/domain/repository/subscription_repository.dart';

class CheckSubscriptionUseCase implements UseCaseWithoutParams<Subscription?> {
  final SubscriptionRepository _repository;

  const CheckSubscriptionUseCase({required SubscriptionRepository repository})
    : _repository = repository;

  @override
  ResultFuture<Subscription?> call() async =>
      _repository.checkSubscription();
}
