import 'package:daily_driver/const/colors.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String detail;
  const DetailsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
        ),
        Text(
          detail,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
