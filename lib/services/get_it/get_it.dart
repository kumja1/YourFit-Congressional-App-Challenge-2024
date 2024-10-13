import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourfit/utils/env/env.dart';
import './get_it.config.dart';
import '../../utils/constants.dart';

@InjectableInit(
  asExtension: true,
  preferRelativeImports: true,
  initializerName: "init",
)
Future<void> configureServices() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseKey
  );
  getIt.init();
}
// hello lol
