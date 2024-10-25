import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourfit/src/app_router.dart';
import 'package:yourfit/src/services/functions/index.dart';
import 'package:yourfit/src/utils/constants.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppRouter _router = getIt<AppRouter>();
  late AuthService _authService = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/app_logo.png", width: 150, height: 100),
          const SizedBox(width: 20),
          const Text("YourFit", style: TextStyle(fontSize: 50))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.wait([
      _authService.init(),
      Future.delayed(const Duration(milliseconds: 2000)),
    ]).then((_) => _router.replaceNamed(
          _authService.currentUser == null ? "/landing_screen" : "/main_screen",
        ));
  }
}
