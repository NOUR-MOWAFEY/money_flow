import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.isEnabled = true,
    this.title,
    this.hintText,
    this.border = 20,
    this.padding,
    this.borderColor,
    this.onTap,
    this.controller,
    this.icon,
    this.showPrefixIcon = true,
    this.centerText = true,
    this.keyboardType,
    this.showCursor = false,
    this.isNormalTextField = false,
  });
  final bool isEnabled;
  final String? title;
  final String? hintText;
  final double border;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final void Function()? onTap;
  final TextEditingController? controller;
  final IconData? icon;
  final bool showPrefixIcon;
  final bool centerText;
  final TextInputType? keyboardType;
  final bool showCursor;
  final bool isNormalTextField;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        cursorColor: AppColors.primaryColor,
        controller: controller,
        style: isNormalTextField
            ? null
            : TextStyle(
                color: AppColors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
        showCursor: showCursor,
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        enabled: isEnabled,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          prefixIcon: showPrefixIcon
              ? Container(padding: EdgeInsets.all(20), child: Icon(icon))
              : null,
          fillColor: AppColors.secondaryColor,
          filled: true,
          contentPadding: padding ?? EdgeInsets.symmetric(vertical: 20),
          hintText: hintText,
          hintStyle: isNormalTextField
              ? TextStyle(
                  color: AppColors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              : null,
          label: title == null ? null : Text(title!),
          labelStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
          border: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          disabledBorder: outlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
