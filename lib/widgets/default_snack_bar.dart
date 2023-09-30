import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class DefaultSnackBar extends StatelessWidget {
  const DefaultSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(
    BuildContext context,
    String text, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textScaleFactor: 1.0,
        ),
        backgroundColor: backgroundColor ?? primaryColor,
        elevation: 2,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    );
  }
}
