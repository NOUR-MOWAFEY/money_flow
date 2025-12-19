import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/category_view.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class AddTransactionBody extends StatelessWidget {
  const AddTransactionBody({
    super.key,
    required this.amountController,
    required this.categoryController,
    required this.dateController,
    required this.transactionType,
    required this.categoryTitle,
    required this.dateTitle,
    required this.iconNotifier,
  });
  final TextEditingController amountController;
  final TextEditingController categoryController;
  final TextEditingController dateController;
  final ValueNotifier<int> transactionType;
  final ValueNotifier<String> categoryTitle;
  final ValueNotifier<String> dateTitle;
  final ValueNotifier<IconData?> iconNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 64),
          child: CustomTextFormFiled(
            keyboardType: TextInputType.number,
            controller: amountController,
            showPrefixIcon: false,
            hintText: 'EGP 0',
            border: 80,
            padding: EdgeInsets.symmetric(vertical: 24),
            borderColor: AppColors.grey,
          ),
        ),
        const SizedBox(height: 32),

        // Category field
        ValueListenableBuilder<String>(
          valueListenable: categoryTitle,
          builder: (BuildContext context, String value, Widget? child) {
            return CustomTextFormFiled(
              icon: iconNotifier.value ?? Icons.category_rounded,
              title: categoryController.text.isEmpty
                  ? 'Category'
                  : categoryController.text,
              isEnabled: false,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryView(
                      categoryController: categoryController,
                      transactionType: transactionType,
                      categoryTitle: categoryTitle,
                      iconNotifier: iconNotifier,
                    ),
                  ),
                );
              },
            );
          },
        ),

        // Date Field
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: dateTitle,
          builder: (BuildContext context, value, Widget? child) {
            return CustomTextFormFiled(
              icon: Icons.calendar_month_sharp,
              title: dateController.text == '' ? 'Date' : dateController.text,
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
                    ? formattedDate = 'Date'
                    : formattedDate = DateFormat.yMMMd()
                          .format(date)
                          .toString();
                dateController.text = formattedDate;
                dateTitle.value = formattedDate;
              },
            );
          },
        ),
      ],
    );
  }
}
