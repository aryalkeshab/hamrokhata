import 'package:flutter/material.dart';

class PrimaryBtnWidget extends StatelessWidget {
  const PrimaryBtnWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.btnColor,
      this.fontSize = 16,
      this.verticalPadding = 16,
      this.horizontalPadding = 0,
      this.borderRadius = 8,
      this.hasElevation = true,
      this.textColor = Colors.white});

  final String title;
  final Color textColor;
  final Color? btnColor;
  final VoidCallback onPressed;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final bool hasElevation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: hasElevation ? 1 : 0,
        backgroundColor: btnColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.button?.copyWith(
              color: textColor,
              fontSize: fontSize,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
