import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/category_view.dart';
import 'package:money_flow/widgets/custom_button.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key});

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
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
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
            hintText: 'EGP 0',
            border: 80,
            padding: EdgeInsets.symmetric(vertical: 24),
            borderColor: AppColors.grey,
          ),
        ),
        const SizedBox(height: 32),
        CustomTextFormFiled(
          title: '  Category',
          isEnabled: false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryView()),
          ),
        ),
        const SizedBox(height: 16),
        CustomTextFormFiled(title: '  Note', isEnabled: false),
        const SizedBox(height: 16),
        CustomTextFormFiled(title: '  Date', isEnabled: false),
      ],
    );
  }
}
