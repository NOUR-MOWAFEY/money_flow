import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class SettleEnvironmentRemainderCheckbox extends StatelessWidget {
  const SettleEnvironmentRemainderCheckbox({
    super.key,
    required this.value,
    required this.currency,
    required this.remaining,
    required this.onChanged,
  });

  final bool value;
  final String currency;
  final double remaining;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black1,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: value,
                activeColor: AppColors.primary,
                onChanged: (val) => onChanged(val ?? true),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'Return remaining $currency ${remaining.toStringAsFixed(2)} to Main Balance',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const CustomText(
                      'Records an Income transaction so funds return to your balance',
                      style: TextStyle(fontSize: 11, color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
