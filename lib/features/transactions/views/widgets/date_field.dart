import 'package:flutter/material.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.date});

  final ValueNotifier<DateTime> date;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: date,
      builder: (BuildContext context, value, Widget? child) =>
          CustomTextFormFiled(
            icon: Icons.calendar_month_sharp,
            title: DateFormatter.dmy(date.value),
            isEnabled: false,
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final now = DateTime.now();
              final current = date.value;

              final picked = await showDatePicker(
                context: context,
                initialDate: current.isAfter(now) ? now : current,
                firstDate: DateTime(
                  current.year < now.year ? current.year : now.year,
                ),
                lastDate: now,
              );

              if (picked != null) {
                date.value = picked;
              }
            },
          ),
    );
  }
}
