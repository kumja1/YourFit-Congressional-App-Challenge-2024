import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/main",
          page: MainRoute.page,
          children: [
            AutoRoute(path: "roadmap", page: RoadmapRoute.page),
            AutoRoute(path: "profile", page: ProfileRoute.page),
            AutoRoute(path: "friends", page: FriendsRoute.page),
          ], 
          initial: true, 
        ),
        AutoRoute(
          path: "/settings",
          page: SettingsRoute.page,
        ),
        AutoRoute(
          page: SplashRoute.page,
          path: "/splash",
          keepHistory: false,
        ),
        AutoRoute(
          page: LandingRoute.page,
          path: "/landing",
          keepHistory: false,
        ),
        AutoRoute(
          path: "/signin",
          page: SigninRoute.page,
          keepHistory: false,
        ),
        AutoRoute(
          path: "/signup",
          page: SignupRoute.page,
          keepHistory: false,
        ),
      ];

  @override
  RouteType get defaultRouteType => RouteType.material();
}
