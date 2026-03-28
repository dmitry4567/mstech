import 'dart:convert';

import 'package:mstech/core/constants/app_constants.dart';
import 'package:mstech/features/subscription/data/model/subscription_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SubscriptionLocalDataSource {
  Future<SubscriptionModel?> checkSubscription();
  Future<void> setSubscription({required SubscriptionModel subscriptionModel});
}

class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource {
  final SharedPreferences _sharedPreferences;

  const SubscriptionLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<SubscriptionModel?> checkSubscription() {
    final subscriptionJson = _sharedPreferences.getString(
      AppConstants.subsriptionKey,
    );

    final subscriptionModel = subscriptionJson != null
        ? SubscriptionModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(subscriptionJson) as Map),
          )
        : null;

    return Future.value(subscriptionModel);
  }

  @override
  Future<void> setSubscription({
    required SubscriptionModel subscriptionModel,
  }) async {
    _sharedPreferences.setString(
      AppConstants.subsriptionKey,
      jsonEncode(subscriptionModel.toJson()),
    );
  }
}
