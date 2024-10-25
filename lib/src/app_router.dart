import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/main_screen", page: MainRoute.page, children: [
          AutoRoute(path: "roadmap", page: RoadmapRoute.page),
          AutoRoute(path: "profile", page: ProfileRoute.page),
          AutoRoute(path: "exercises", page: ExercisesRoute.page),
          AutoRoute(page: LandingRoute.page, path: "t")
        ]),
        AutoRoute(
          path: "/settings_screen",
          page: SettingsRoute.page,
        ),
      
        AutoRoute(
            page: SplashRoute.page,
            path: "/splash_screen",
            keepHistory: false,
            initial: true),
        AutoRoute(
          page: LandingRoute.page,
          path: "/landing_screen",
          keepHistory: false,
        ),
        AutoRoute(
          path: "/signin_screen",
          page: SigninRoute.page,
          keepHistory: false,
        ),
        AutoRoute(
          path: "/signup_screen",
          page: SignupRoute.page,
          keepHistory: false,
        ),

        AutoRoute(page: ResetPasswordRoute.page,path:"/reset_password_screen"
        ),
     
      ];

  @override
  RouteType get defaultRouteType => RouteType.material();
}
