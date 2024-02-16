import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/utility/snack_bar_handler.dart';

mixin SnackBarMixin {
  void showSnackBar({
    required String message,
    required BuildContext context,
    bool isBottomPadding = true,
    bool isSnackBarHandler = false,
  }) {
    SnackBarHandler(context: context).showSnackBar(
      message: message,
      color: Colors.red,
    );
  }
}
