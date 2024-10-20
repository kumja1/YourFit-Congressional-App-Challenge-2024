import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourfit/src/app_router.dart';
import 'package:yourfit/src/utils/constants.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppRouter _router = getIt<AppRouter>();

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
    
    _router.replaceNamed("/main",onFailure: (failure) => print(failure),);
  }

}
