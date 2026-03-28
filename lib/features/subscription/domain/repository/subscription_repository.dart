import 'package:mstech/core/utils/typedefs.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';

abstract class SubscriptionRepository {
  ResultFuture<Subscription?> checkSubscription();
  ResultVoid setSubscription({required Subscription subscription});
}
