import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class RecurringDateField extends StatelessWidget {
  const RecurringDateField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.isOptional = false,
  });

  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isOptional;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label,
          maxLines: 1,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextFormFiled(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                isNormalTextField: true,
                showPrefixIcon: false,
                centerText: false,
                isEnabled: false,
                title: selectedDate != null
                    ? DateFormatter.ddmy(selectedDate!)
                    : (isOptional ? 'None' : DateFormatter.ddmy(now)),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: firstDate ?? DateTime(2020),
                    initialDate: selectedDate ?? now,
                    lastDate: lastDate ?? DateTime(2030),
                  );
                  if (pickedDate != null) {
                    onDateSelected(pickedDate);
                  }
                },
              ),
            ),
            if (isOptional && selectedDate != null) ...[
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onDateSelected(null),
                child: Container(
                  height: 56,
                  width: 44,
                  decoration: BoxDecoration(
                    color: AppColors.black1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.icon,
                    size: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
