import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.formatter,
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
  final List<TextInputFormatter>? formatter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        showCursor: showCursor,
        cursorColor: AppColors.primaryColor,
        cursorHeight: 20,

        controller: controller,

        style: isNormalTextField
            ? null
            : const TextStyle(
                color: AppColors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),

        textAlign: centerText ? TextAlign.center : TextAlign.start,
        enabled: isEnabled,
        keyboardType: keyboardType,
        inputFormatters: formatter,

        decoration: InputDecoration(
          contentPadding: padding ?? const EdgeInsets.symmetric(vertical: 20),
          alignLabelWithHint: false,

          prefixIcon: showPrefixIcon
              ? Container(padding: const EdgeInsets.all(20), child: Icon(icon))
              : null,

          fillColor: AppColors.secondaryColor,
          filled: true,

          hintText: hintText,
          hintStyle: isNormalTextField
              ? const TextStyle(
                  color: AppColors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              : null,

          labelText: title,
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),

          border: _borderBuilder(),
          enabledBorder: _borderBuilder(),
          focusedBorder: _borderBuilder(),
          disabledBorder: _borderBuilder(),
        ),
      ),
    );
  }

  OutlineInputBorder _borderBuilder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
