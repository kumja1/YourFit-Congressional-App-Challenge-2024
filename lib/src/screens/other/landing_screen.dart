import 'package:async_button_builder/async_button_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:text_wrap_auto_size/text_wrap_auto_size.dart';
import 'package:yourfit/src/app_router.dart';
import 'package:yourfit/src/utils/constants.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  AppRouter _router = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            NiceButtons(
                onTap: (finish) {},
                stretch: false,
                height: 40,
                width: 300,
                disabled: true,
                startColor: const Color.fromARGB(255, 153, 151, 151),
                endColor: const Color.fromARGB(255, 153, 151, 151),
                borderColor: const Color.fromARGB(255, 153, 151, 151),
                borderRadius: 10,
                child: const Text(
                  "INVITE ONLY",
                  style: TextStyle(color: Colors.white),
                )),
            const Icon(Icons.lock),
            const SizedBox(height: 10),
            GestureDetector(
              child: const Text("Login", style: TextStyle(color: Colors.blue)),
              onTap: () async => _router.navigateNamed("/signin_screen"),
            )
          ],
        ),
      ),
    );
  }
}
