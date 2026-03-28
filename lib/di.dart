import 'package:mstech/core/router/app_router.dart';
import 'package:mstech/features/subscription/data/datasource/subscription_local_datasource.dart';
import 'package:mstech/features/subscription/data/repository/subscription_repository_impl.dart';
import 'package:mstech/features/subscription/domain/repository/subscription_repository.dart';
import 'package:mstech/features/subscription/domain/usecase/check_subscription.dart';
import 'package:mstech/features/subscription/domain/usecase/set_subscription.dart';
import 'package:mstech/features/subscription/presentation/cubit/info_subsription_cubit.dart';
import 'package:mstech/features/subscription/presentation/cubit/subscription_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AppRouter());

  sl.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  sl.registerLazySingleton<SubscriptionLocalDataSource>(
    () => SubscriptionLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton(() => CheckSubscriptionUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetSubscriptionUseCase(repository: sl()));

  sl.registerLazySingleton(
    () => SubscriptionCubit(setSubscriptionUseCase: sl()),
  );
  sl.registerLazySingleton(() => InfoSubsriptionCubit());

  await sl.allReady();
}
