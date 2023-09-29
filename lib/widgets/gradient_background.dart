import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: japaneseGradient,
      ),
    );
  }
}
