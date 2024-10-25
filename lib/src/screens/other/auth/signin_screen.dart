import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourfit/src/app_router.dart';
import 'package:yourfit/src/utils/constants.dart';
import 'package:yourfit/src/utils/functions.dart';
import '../../../services/functions/index.dart';

@RoutePage()
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthService _authService = getIt<AuthService>();
  final AppRouter _router = getIt<AppRouter>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldState =
      GlobalKey<ScaffoldMessengerState>();
  late TextEditingController _email;
  late TextEditingController _password;
  bool _passwordVisible = false;

  bool _isSignInDisabled = false;

  _buildForm() {
    return Column(
      children: [
        Form(
          key: _formState,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 360,
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    hoverColor: Colors.blue,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (val) => emailValidator.build(val),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 360,
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _password,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: _setPasswordVisibility,
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: Colors.blue,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Positioned(
          top: 5,
          bottom: 5,
          right: 0,
          child: Align(
            alignment: const Alignment(0.8, 0),
            child: TextButton(
              onPressed: () => _router.navigateNamed("/reset_password_screen"),
              style: const ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: Colors.blue,
                ),
              )),
              child: const Text("Forgot Password?"),
            ),
          ),
        ),
        const SizedBox(height: 30),
        NiceButtons(
          disabled: _isSignInDisabled,
          onTap: (Function finish) async =>
              await (_signInWithEmail().catchError((e) {
            print(e);
            finish();
          }).whenComplete(() => finish())),
          startColor: Colors.blue,
          width: 300,
          stretch: false,
          height: 40,
          progress: true,
          borderRadius: 10,
          child: const Text(
            "Sign in",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign in",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 30.0),
          _buildForm(),
          const SizedBox(height: 20),
          /**   Align(
            alignment: const Alignment(0, 7),
            child: Text.rich(
              TextSpan(text: "New User? ", children: [
                TextSpan(
                  text: "Get Started",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    decorationColor: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () async => await _router.navigateNamed("/signup_screen"),
                )
              ]),
            ),
          )
         */
        ],
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

  void _displayErr({String? message, Exception? error}) {
    showSnackBar(_scaffoldState.currentContext!, AnimatedSnackBarType.error,
        "An error occured: ${message ?? (error is AuthException ? error.message : error)}");
  }

  Future<void> _signInWithOAuth(OAuthProvider provider) async =>
      await _authService.signInWithOAuth(provider);

  Future<void> _signInWithEmail() async {
    bool isValid = _formState.currentState!.validate();

    if (!isValid) {
      _displayErr(message: "Invalid form response");
      return;
    }

    bool success = await _authService.signInWithEmail(
      onError: (err) => _displayErr(error: err),
      email: _email.text,
      password: _password.text,
    );

    if (success) {
      await _router.navigateNamed("/main_screen");
    }
  }

  void _setPasswordVisibility() =>
      setState(() => _passwordVisible = !_passwordVisible);
}
