import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CustomToggleSwitch<T> extends StatefulWidget {
  const CustomToggleSwitch({
    super.key,
    required this.values,
    required this.onChanged,
    this.current,
    this.itemLabelBuilder,
    this.indicatorSize,
    this.borderWidth = 4.0,
    this.selectedIconScale = 1.05,
    this.indicatorColor = AppColors.primary,
    this.backgroundColor = AppColors.black1,
  });

  final List<T> values;
  final T? current;
  final ValueChanged<T> onChanged;
  final String Function(T item)? itemLabelBuilder;
  final Size? indicatorSize;
  final double borderWidth;
  final double selectedIconScale;
  final Color indicatorColor;
  final Color backgroundColor;

  @override
  State<CustomToggleSwitch<T>> createState() => _CustomToggleSwitchState<T>();
}

class _CustomToggleSwitchState<T> extends State<CustomToggleSwitch<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.current ?? widget.values.first;
  }

  @override
  void didUpdateWidget(covariant CustomToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final current = widget.current;
    if (current != null && current != _currentValue) {
      _currentValue = current;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : null;
        final calculatedWidth =
            (availableWidth != null && widget.values.isNotEmpty)
            ? (availableWidth - (widget.borderWidth * 2)) / widget.values.length
            : 170.0;
        final effectiveSize =
            widget.indicatorSize ??
            Size.fromWidth(calculatedWidth > 0 ? calculatedWidth : 170.0);

        return AnimatedToggleSwitch<T>.size(
          current: _currentValue,
          values: widget.values,
          iconList: widget.values.map((item) {
            final label = widget.itemLabelBuilder != null
                ? widget.itemLabelBuilder!(item)
                : (item is Enum
                      ? StringUtils.capitalizeFirstLetter(item.name)
                      : item.toString());
            return CustomText(
              label,
              style: TextStyle(
                fontSize: 14,
                color: _currentValue == item ? Colors.white : Colors.black54,
              ),
            );
          }).toList(),
          indicatorSize: effectiveSize,
          borderWidth: widget.borderWidth,
          selectedIconScale: widget.selectedIconScale,
          onChanged: (value) {
            setState(() => _currentValue = value);
            widget.onChanged(value);
          },
          style: ToggleStyle(
            borderColor: Colors.transparent,
            borderRadius: BorderRadius.circular(32),
            indicatorColor: widget.indicatorColor,
            backgroundColor: widget.backgroundColor,
            boxShadow: const [],
          ),
        );
      },
    );
  }
}
