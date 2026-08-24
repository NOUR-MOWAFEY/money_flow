import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.hintText,
    this.value,
    this.height = 60,
    this.maxMenuHeight = 200,
    this.itemTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  });

  final List<T> items;
  final String Function(T item) itemLabelBuilder;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final T? value;
  final double height;
  final double maxMenuHeight;
  final TextStyle itemTextStyle;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,

        items: items
            .map(
              (item) => DropdownItem<T>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(itemLabelBuilder(item), style: itemTextStyle),
                ),
              ),
            )
            .toList(),

        onChanged: onChanged,

        hint: CustomText(hintText ?? '', style: TextStyle(fontWeight: .w600)),

        buttonStyleData: ButtonStyleData(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.black1,
          ),
        ),

        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 22,
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: maxMenuHeight,
          isOverButton: true,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.black1,
            boxShadow: const [],
          ),
        ),

        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}
