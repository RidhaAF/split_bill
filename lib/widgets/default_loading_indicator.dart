import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  const DefaultLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
      ),
    );
  }
}
