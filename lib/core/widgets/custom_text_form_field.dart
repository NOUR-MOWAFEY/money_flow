import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/core/constants/app_colors.dart';

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
    this.validator,
    this.focusNode,
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
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: TextFormField(
        focusNode: focusNode,
        maxLength: 20,

        maxLengthEnforcement: MaxLengthEnforcement.none,

        minLines: 1,
        maxLines: 2,

        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) => null,

        validator: validator,

        showCursor: showCursor,

        cursorColor: AppColors.primary,

        cursorHeight: 20,

        controller: controller,

        autovalidateMode: .onUserInteraction,

        style: isNormalTextField
            ? null
            : const TextStyle(
                color: AppColors.text,
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

          fillColor: AppColors.black1,
          filled: true,

          hintText: hintText,
          hintStyle: isNormalTextField
              ? const TextStyle(
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              : null,

          labelText: title,
          labelStyle: const TextStyle(
            color: AppColors.text,
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
