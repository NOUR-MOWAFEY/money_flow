import 'package:flutter/material.dart';
import 'package:money_flow/utils/date_formatter.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

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
            title: DateFormatter.dateFormatter(date.value),
            isEnabled: false,
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final DateTime? date;

              date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime.now(),
              );

              this.date.value = date ?? DateTime.now();
            },
          ),
    );
  }
}
