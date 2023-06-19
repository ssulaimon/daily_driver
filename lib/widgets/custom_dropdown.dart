import 'package:daily_driver/const/colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem<String>> dropdownMenuItem;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  final String? value;

  const CustomDropDown({
    super.key,
    this.validator,
    this.value,
    this.onSave,
    required this.hint,
    required this.dropdownMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      decoration: const InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      hint: Text(hint),
      items: dropdownMenuItem,
      onChanged: onSave,
      value: value,
    );
  }
}
