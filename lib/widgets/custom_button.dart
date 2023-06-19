import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Widget? child;
  final Color? borderColor;
  final Color? backGroundColor;
  final Function()? onTap;
  final double? width;
  final EdgeInsets? padding;
  final Color? textColor;
  const CustomButton({
    super.key,
    this.child,
    this.textColor,
    this.padding,
    this.onTap,
    this.width,
    this.borderColor,
    this.backGroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: backGroundColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            )),
        child: child ??
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
      ),
    );
  }
}
