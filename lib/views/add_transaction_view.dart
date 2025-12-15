import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/category_view.dart';
import 'package:money_flow/widgets/custom_button.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key});
  static final categoryController = TextEditingController();
  static final dateController = TextEditingController();
  static final noteController = TextEditingController();
  static final categoryTitle = ValueNotifier<String>('Category');
  static final ValueNotifier<String> dateTitle = ValueNotifier<String>('Date');
  static IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: const CustomButton(),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await Future.delayed(Duration(seconds: 1));
            _clearFields();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            ToggleSwitch(
              minWidth: double.infinity,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['Expenses', 'Income'],
              onToggle: (index) {},
            ),
            const SizedBox(height: 32),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: ExpensesBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 64),
          child: CustomTextFormFiled(
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
          valueListenable: AddTransactionView.categoryTitle,
          builder: (BuildContext context, String value, Widget? child) {
            return CustomTextFormFiled(
              icon: AddTransactionView.icon ?? Icons.category_rounded,
              title: AddTransactionView.categoryController.text.isEmpty
                  ? 'Category'
                  : AddTransactionView.categoryController.text,
              isEnabled: false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryView()),
              ),
            );
          },
        ),

        // Date Field
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: AddTransactionView.dateTitle,
          builder: (BuildContext context, value, Widget? child) {
            return CustomTextFormFiled(
              icon: Icons.calendar_month_sharp,
              title: AddTransactionView.dateController.text == ''
                  ? 'Date'
                  : AddTransactionView.dateController.text,
              isEnabled: false,
              onTap: () async {
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
                AddTransactionView.dateController.text = formattedDate;
                AddTransactionView.dateTitle.value = formattedDate;
              },
            );
          },
        ),
      ],
    );
  }
}

void _clearFields() {
  AddTransactionView.categoryController.clear();
  AddTransactionView.dateController.clear();
  AddTransactionView.categoryTitle.value = 'Category';
  AddTransactionView.dateTitle.value = 'Date';
}
