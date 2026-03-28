import 'package:mstech/features/subscription/data/model/subscription_model.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';

class SubscriptionMapper {
  SubscriptionModel toModel(Subscription subscription) {
    return SubscriptionModel(id: subscription.id, name: subscription.name);
  }

  Subscription toEntity(SubscriptionModel subscriptionModel) {
    return Subscription(id: subscriptionModel.id, name: subscriptionModel.name);
  }
}
