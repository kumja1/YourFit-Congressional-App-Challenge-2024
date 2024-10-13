import 'package:flutter/material.dart';
import 'package:yourfit/auth/signin_screen.dart';
import 'services/get_it/get_it.dart';

void main() async {
  await configureServices();
  runApp(const YourFitApp());
}

class YourFitApp extends StatelessWidget {
  const YourFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourFit App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(22, 120, 250, 1),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
        fontFamily: "Lilita",
      ),
      home: AppScaffold(),
    );
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<StatefulWidget> createState() => _AppScaffold();
}

class _AppScaffold extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SigninScreen());
  }
}
