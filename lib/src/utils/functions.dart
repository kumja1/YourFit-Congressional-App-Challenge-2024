import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    BuildContext context, AnimatedSnackBarType snackBarType, String message) {
  var snackbar = AnimatedSnackBar.material(
    message,
    type: snackBarType,
  );

  snackbar.show(context);
}
