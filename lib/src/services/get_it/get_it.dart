import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourfit/src/utils/env/env.dart';
import 'get_it.config.dart';
import '../../utils/constants.dart';
import 'package:flutter_js/flutter_js.dart';

@InjectableInit(
  asExtension: true,
  preferRelativeImports: true,
  initializerName: "init",
)
Future<void> configureServices() async {
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
  getIt.registerSingleton<JavascriptRuntime>(getJavascriptRuntime(),dispose:(i)=>i.dispose(),);
  getIt.init();
}
// hello lol
// hello
