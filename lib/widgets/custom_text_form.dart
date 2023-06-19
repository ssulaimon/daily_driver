import 'package:daily_driver/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextInputType? keyBoardType;
  final bool? obsecure;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final int? minLenght;

  const CustomTextForm({
    super.key,
    this.minLenght,
    this.textEditingController,
    this.validator,
    this.obsecure,
    this.keyBoardType,
    required this.icon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: obsecure ?? false,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.red,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
        hintText: hintText,
        prefixIcon: icon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
