import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final TextStyle? style;
  final Color? backgroundColor;
  final bool centerTitle;
  final double? elevation;
  const DefaultAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.style,
    this.backgroundColor,
    this.centerTitle = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title ?? '',
          style: style != null ? style! : null,
          textScaleFactor: 1.0,
        ),
        leading: leading,
        actions: actions,
        backgroundColor: backgroundColor ?? primaryColor,
        centerTitle: centerTitle,
        elevation: elevation ?? 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
