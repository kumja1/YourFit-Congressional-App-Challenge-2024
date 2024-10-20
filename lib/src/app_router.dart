import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: SplashRoute.page,
            path: "/splash_screen",
            initial: true,
            keepHistory: false),
            AutoRoute(page: LandingRoute.page,path:"/landing_page",keepHistory: false),
        AutoRoute(
            path: "/main",
            page: MainRoute.page,
            children: [
              AutoRoute(path: "roadmap", page: RoadmapRoute.page),
              AutoRoute(path: "profile", page: ProfileRoute.page),
              AutoRoute(path: "friends", page: FriendsRoute.page),
            ]),
        AutoRoute(path: "/settings", page: SettingsRoute.page),
        AutoRoute(path: "/signin", page: SigninRoute.page, keepHistory: false),
        AutoRoute(path: "/signup", page: SignupRoute.page, keepHistory: false),
      ];

  @override
  RouteType get defaultRouteType => RouteType.material();
}
