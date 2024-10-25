import 'package:async_button_builder/async_button_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourfit/src/services/functions/index.dart';

import '../../../utils/constants.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _email;
  final AuthService _authService = getIt<AuthService>();
  final GlobalKey<FormFieldState> _emailFieldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Reset Password"),
        const SizedBox(height: 30),
        TextFormField(
          key: _emailFieldState,
          controller: _email,
          decoration: const InputDecoration(
              label: Text("Email"), hintText: "Enter your email"),
          validator: (val) => emailValidator.build(val),
        ),
        const SizedBox(
          height: 10,
        ),
        AsyncButtonBuilder(
          showSuccess: true,
          successWidget: const Text("Password reset sent"),
          onPressed: _resetPassword,
          builder: (context, child, callback, buttonState) =>
              TextButton(onPressed: callback, child: child),
          child: const Text("Reset Password"),
        )
      ],
    );
  }

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  Future<void> _resetPassword() async {
    if (_emailFieldState.currentState!.isValid) {
      await _authService.resetPassword(_email.text);
    }
  }
}
