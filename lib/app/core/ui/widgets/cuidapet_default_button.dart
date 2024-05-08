import 'package:flutter/material.dart';

class CuidapetDefaultButton extends StatelessWidget {
  const CuidapetDefaultButton(
      {super.key,
      required this.onPressed,
      this.radius = 10,
      this.color,
      required this.label,
      this.labelStyle,
      this.padding,
      this.width = double.infinity,
      this.height = 55});
  final VoidCallback? onPressed;
  final double radius;
  final Color? color;
  final TextStyle? labelStyle;
  final String label;
  final EdgeInsets? padding;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: padding,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      child: Text(
        label,
        style: labelStyle ??
            const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
      ),
    );
  }
}
