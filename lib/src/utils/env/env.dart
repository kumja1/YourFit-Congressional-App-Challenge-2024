import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env", obfuscate: true, useConstantCase: true, interpolate: true)
class Env {
  @EnviedField(varName: "SUPABASE_KEY")
  static final String supabaseKey = _Env.supabaseKey;
  @EnviedField(varName: "SUPABASE_URL")
  static final String supabaseUrl = _Env.supabaseUrl;
  @EnviedField(varName: "GROQ_KEY")
  static final String groqKey = _Env.groqKey;
  @EnviedField(varName: "MISTRAL_KEY")
  static final String mistralKey = _Env.mistralKey;


}
