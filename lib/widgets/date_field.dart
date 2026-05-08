import 'package:flutter/material.dart';
import 'package:money_flow/utils/date_formatter.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class DateField extends StatefulWidget {
  const DateField({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormFiled(
      icon: Icons.calendar_month_sharp,
      title: widget.dateController.text,
      isEnabled: false,
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        DateTime? date;
        String formattedDate;

        date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime.now(),
        );

        date == null
            ? formattedDate = DateFormatter.dateNow
            : formattedDate = DateFormatter.dateFormatter(date);

        setState(() => widget.dateController.text = formattedDate);
      },
    );
  }
}
