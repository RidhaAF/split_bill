import 'package:flutter/material.dart';
import 'package:split_bill/widgets/default_loading_indicator.dart';

class DefaultButton extends StatelessWidget {
  final bool? isLoading;
  final Function? onPressed;
  final Function? onLongPress;
  final String text;
  const DefaultButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.onLongPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => onPressed != null ? onPressed!() : null,
        onLongPress: () => onLongPress != null ? onLongPress!() : null,
        child: isLoading == true
            ? const DefaultLoadingIndicator()
            : Text(
                text,
                textScaleFactor: 1.0,
              ),
      ),
    );
  }
}
