import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class DefaultListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? leadingAndTrailingTextStyle;
  final double? horizontalVisualDensity;
  final double? verticalVisualDensity;
  final Function? onTap;
  const DefaultListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.horizontalVisualDensity,
    this.verticalVisualDensity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      titleTextStyle: titleTextStyle,
      subtitleTextStyle:
          subtitleTextStyle ?? Theme.of(context).textTheme.bodyMedium,
      leadingAndTrailingTextStyle: leadingAndTrailingTextStyle ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: medium,
              ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap == null ? null : () => onTap!(),
    );
  }
}
