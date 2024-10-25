import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'src/app_router.dart';
import 'src/services/get_it/get_it.dart';
import 'src/utils/constants.dart';

void main() async {
  await configureServices();
  runApp(YourFitApp());
}

class YourFitApp extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();

  YourFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
        child: MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'YourFit App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(22, 120, 250, 1),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
        fontFamily: "Lilita",
      ),
    ));
  }
}
