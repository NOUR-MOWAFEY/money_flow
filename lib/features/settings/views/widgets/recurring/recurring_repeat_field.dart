import 'package:flutter/material.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_dropdown.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

class RecurringRepeatField extends StatelessWidget {
  const RecurringRepeatField({
    super.key,
    required this.selectedFrequency,
    required this.onChanged,
  });

  final RecurrenceFrequency? selectedFrequency;
  final ValueChanged<RecurrenceFrequency?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Repeat: ',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        CustomDropdown<RecurrenceFrequency>(
          value: selectedFrequency,
          hintText: StringUtils.capitalizeFirstLetter(
            selectedFrequency?.name ?? 'Repeat',
          ),
          items: RecurrenceFrequency.values,
          itemLabelBuilder: (item) =>
              StringUtils.capitalizeFirstLetter(item.name),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
