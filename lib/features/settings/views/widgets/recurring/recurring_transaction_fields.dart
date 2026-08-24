import 'package:flutter/material.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_data_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_amount_field.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_category_field.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_date_field.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_repeat_field.dart';

class RecurringTransactionFields extends StatelessWidget {
  const RecurringTransactionFields({super.key, required this.dataModel});

  final RecurringTransactionDataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecurringAmountField(amountController: dataModel.amountController),

        const SizedBox(height: 24),

        // Category field
        RecurringCategoryField(
          transactionType: dataModel.type,
          category: dataModel.category,
        ),

        const SizedBox(height: 16),

        ValueListenableBuilder<RecurrenceFrequency>(
          valueListenable: dataModel.frequency,
          builder: (context, frequency, _) {
            return RecurringRepeatField(
              selectedFrequency: frequency,
              onChanged: (value) {
                if (value != null) {
                  dataModel.frequency.value = value;
                }
              },
            );
          },
        ),

        const SizedBox(height: 16),

        ValueListenableBuilder<DateTime>(
          valueListenable: dataModel.startDate,
          builder: (context, startDate, _) {
            return RecurringDateField(
              label: 'Start Date: ',
              selectedDate: startDate,
              onDateSelected: (newDate) {
                if (newDate != null) {
                  dataModel.startDate.value = newDate;
                }
              },
            );
          },
        ),

        const SizedBox(height: 16),

        ValueListenableBuilder<DateTime?>(
          valueListenable: dataModel.endDate,
          builder: (context, endDate, _) {
            return RecurringDateField(
              label: 'End Date (Optional): ',
              selectedDate: endDate,
              isOptional: true,
              onDateSelected: (newDate) {
                dataModel.endDate.value = newDate;
              },
            );
          },
        ),
      ],
    );
  }
}
