import 'package:dartz/dartz.dart';
import 'package:mstech/core/errors/exceptions.dart';
import 'package:mstech/core/errors/failures.dart';
import 'package:mstech/core/utils/typedefs.dart';
import 'package:mstech/features/subscription/data/datasource/subscription_local_datasource.dart';
import 'package:mstech/features/subscription/data/mapper/subscription_mapper.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';
import 'package:mstech/features/subscription/domain/repository/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionLocalDataSource _localDataSource;

  const SubscriptionRepositoryImpl({
    required SubscriptionLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  ResultFuture<Subscription?> checkSubscription() async {
    try {
      final subscriptionModel = await _localDataSource.checkSubscription();

      final subscription = subscriptionModel != null
          ? SubscriptionMapper().toEntity(subscriptionModel)
          : null;

      return Right(subscription);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultVoid setSubscription({required Subscription subscription}) async {
    try {
      final subscriptionModel = SubscriptionMapper().toModel(subscription);

      await _localDataSource.setSubscription(
        subscriptionModel: subscriptionModel,
      );

      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
