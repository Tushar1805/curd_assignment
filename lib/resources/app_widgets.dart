import 'package:curd_assignment/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.name,
    required this.borderRadius,
    required this.alignment,
    required this.onPressed,
    this.textPadding,
    this.backgroundColor,
    this.nameColor,
    this.nameSize,
    this.textWidget,
  });
  final String? name;
  final double? borderRadius;
  final Color? backgroundColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? textPadding;
  final VoidCallback onPressed;
  final Color? nameColor;
  final double? nameSize;
  final Widget? textWidget;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: textPadding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: textWidget ??
              Text(
                name ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: nameColor ?? whiteColor,
                      fontSize: nameSize ?? 16,
                      fontWeight: FontWeight.w700,
                    ),
              ),
        ),
      ),
    );
  }
}

class CustomStatusBarWidget extends StatelessWidget {
  const CustomStatusBarWidget({
    super.key,
    required this.title,
    this.text,
    this.height,
    this.titlePositionTop,
    this.fontSize,
    this.actions
  });
  final String? title;
  final Widget? text;
  final double? height;
  final double? titlePositionTop;
  final double? fontSize;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: whiteColor),
      title: text ??
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: whiteColor,
                  fontSize: fontSize ?? 24,
                ),
          ),
      actions: actions,
    );
  }
}
