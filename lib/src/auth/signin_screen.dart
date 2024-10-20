import 'package:async_button_builder/async_button_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourfit/src/utils/constants.dart';
import 'package:yourfit/src/widgets/text_icon_button.dart';
import '../services/functions/index.dart';

@RoutePage()
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController _email;
  late TextEditingController _password;
  final AuthService _authService = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Signin to YourFit",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AsyncButtonBuilder(
                      child: Text("Test"),
                      onPressed: () async =>
                          _signInWithOAuth(OAuthProvider.google),
                      builder: (context, child, buttonCallback, _) {
                        return OutlinedButton.icon(
                          onPressed: buttonCallback,
                          label: child,
                          icon: Icon(Icons.facebook),
                        );
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextIconButton(
                    "Continue with Facebook",
                    onPressed: () => null,
                    icon: Icons.facebook_rounded,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      height: 35,
                      width: 210,
                      child: TextIconButton("Continue with Email",
                          onPressed: () => null, icon: Icons.email))
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    endIndent: 5.0,
                    indent: 0.0,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("New User?"),
                ),
                Expanded(
                  child: Divider(),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              child: const Text("Get Started",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signInWithOAuth(OAuthProvider provider) async => await _authService.signInWithOAuth(provider);

  Future<void> _signInWithEmail() async {
  
  }
}
