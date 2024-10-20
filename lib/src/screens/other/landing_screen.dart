import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text.rich(
                style: TextStyle(fontSize: 90),
                TextSpan(
                  text: "Get fit\n",
                  children: [
                    TextSpan(
                        text: "your\n",
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                    TextSpan(text: " way"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
