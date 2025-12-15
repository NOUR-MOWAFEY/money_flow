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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        style: TextStyle(
          color: AppColors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        showCursor: false,
        textAlign: TextAlign.center,
        enabled: isEnabled,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          prefixIcon: showPrefixIcon
              ? Container(padding: EdgeInsets.all(20), child: Icon(icon))
              : null,
          fillColor: AppColors.secondaryColor,
          filled: true,
          contentPadding: padding ?? EdgeInsets.symmetric(vertical: 20),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
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
