import 'package:auto_route/auto_route.dart';
import 'package:mstech/di.dart' as di;
import 'package:mstech/features/home/presentation/screens/home_page.dart';
import 'package:mstech/features/home/presentation/screens/welcome_page.dart';
import 'package:mstech/features/subscription/domain/usecase/check_subscription.dart';
import 'package:mstech/features/subscription/presentation/cubit/info_subsription_cubit.dart';
import 'package:mstech/features/subscription/presentation/pages/info_subscription_page.dart';
import 'package:mstech/features/subscription/presentation/pages/subscription_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/welcome', page: WelcomeRoute.page),
    AutoRoute(path: '/subscription', page: SubscriptionRoute.page),
    AutoRoute(
      initial: true,
      path: '/info_subscription',
      guards: [HasSubscriptionGuard()],
      page: InfoSubscriptionRoute.page,
    ),
  ];
}

class HasSubscriptionGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final result = await di.sl<CheckSubscriptionUseCase>()();

    result.fold((e) => router.push(const WelcomeRoute()), (subscription) {
      if (subscription != null) {
        di.sl<InfoSubsriptionCubit>().setSubscriptionInfo(
          subscription: subscription,
        );

        resolver.next(true);
      } else {
        router.push(const WelcomeRoute());
      }
    });
  }
}
