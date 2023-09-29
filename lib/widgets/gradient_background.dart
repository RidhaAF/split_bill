import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  const GradientBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: japaneseGradient,
      ),
      child: child,
    );
  }
}
